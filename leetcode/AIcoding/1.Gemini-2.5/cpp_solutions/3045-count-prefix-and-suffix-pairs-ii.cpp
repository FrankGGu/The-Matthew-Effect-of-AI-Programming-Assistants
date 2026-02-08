#include <string>
#include <vector>
#include <algorithm> // For std::max

struct TrieNode {
    TrieNode* children[26];
    int word_count_at_node; // Counts how many words *ending* at this node have been inserted.

    TrieNode() : word_count_at_node(0) {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
    }
    // No explicit destructor for competitive programming to avoid deep recursion issues
    // or for simplicity, as memory is reclaimed after program termination.
};

class Trie {
public:
    TrieNode* root;

    Trie() {
        root = new TrieNode();
    }
};

struct HashPair {
    long long h1, h2;
    bool operator==(const HashPair& other) const {
        return h1 == other.h1 && h2 == other.h2;
    }
};

class Solution {
public:
    // Static members for rolling hash parameters and precomputed powers
    static long long P1, M1, P2, M2;
    static std::vector<long long> powers1, powers2;
    static bool powers_precomputed;

    // Function to precompute powers of bases for hashing
    void precompute_powers(int max_len) {
        // Only precompute if not already done or if current max_len exceeds previous capacity
        if (powers_precomputed && powers1.size() >= max_len + 1) {
            return;
        }

        powers1.resize(max_len + 1);
        powers2.resize(max_len + 1);

        powers1[0] = 1;
        powers2[0] = 1;
        for (int i = 1; i <= max_len; ++i) {
            powers1[i] = (powers1[i-1] * P1) % M1;
            powers2[i] = (powers2[i-1] * P2) % M2;
        }
        powers_precomputed = true;
    }

    // Function to compute prefix hashes for a given string
    // hashes[i] stores the hash of s[0...i]
    std::vector<HashPair> compute_prefix_hashes(const std::string& s) {
        int n = s.length();
        std::vector<HashPair> hashes(n);
        if (n == 0) return hashes;

        hashes[0] = {(s[0] - 'a' + 1), (s[0] - 'a' + 1)};
        for (int i = 1; i < n; ++i) {
            hashes[i].h1 = (hashes[i-1].h1 * P1 + (s[i] - 'a' + 1)) % M1;
            hashes[i].h2 = (hashes[i-1].h2 * P2 + (s[i] - 'a' + 1)) % M2;
        }
        return hashes;
    }

    // Function to get hash of substring s[start...end] using precomputed prefix hashes
    HashPair get_substring_hash(int start, int end, const std::vector<HashPair>& prefix_hashes) {
        long long h1 = prefix_hashes[end].h1;
        long long h2 = prefix_hashes[end].h2;

        if (start > 0) {
            // Subtract hash of s[0...start-1] shifted by appropriate power
            h1 = (h1 - (prefix_hashes[start-1].h1 * powers1[end - start + 1]) % M1 + M1) % M1;
            h2 = (h2 - (prefix_hashes[start-1].h2 * powers2[end - start + 1]) % M2 + M2) % M2;
        }
        return {h1, h2};
    }

    long long countPrefixSuffixPairs(std::vector<std::string>& words) {
        long long total_pairs = 0;
        Trie trie;

        // Determine maximum word length to precompute powers efficiently
        int max_word_len = 0;
        for (const std::string& word : words) {
            max_word_len = std::max(max_word_len, (int)word.length());
        }
        precompute_powers(max_word_len);

        // Iterate through each word in the input array
        for (const std::string& w : words) {
            int n = w.length();
            // Problem constraints state 1 <= words[i].length <= 100, so no empty strings.
            // If empty strings were allowed, they would need special handling.

            // Compute prefix hashes for the current word 'w'
            std::vector<HashPair> current_word_prefix_hashes = compute_prefix_hashes(w);

            TrieNode* curr = trie.root;
            // Traverse the Trie with 'w'
            for (int k = 0; k < n; ++k) { // k is the current character index in w
                int char_idx = w[k] - 'a';
                if (!curr->children[char_idx]) {
                    curr->children[char_idx] = new TrieNode();
                }
                curr = curr->children[char_idx];

                // At this point, `curr` represents the prefix `w[0...k]`.
                // We need to check if this prefix `w[0...k]` is also a suffix of `w`.
                // Length of current prefix/suffix is `k + 1`.
                HashPair hash_prefix = get_substring_hash(0, k, current_word_prefix_hashes);
                HashPair hash_suffix = get_substring_hash(n - (k + 1), n - 1, current_word_prefix_hashes);

                if (hash_prefix == hash_suffix) {
                    // If `w[0...k]` is both a prefix and a suffix of `w`,
                    // then any previously inserted word `words[i]` that is *exactly* `w[0...k]`
                    // forms a valid pair `(i, j)` with the current word `w` (which is `words[j]`).
                    // `curr->word_count_at_node` stores how many such `words[i]` exist.
                    total_pairs += curr->word_count_at_node;
                }
            }
            // After traversing all prefixes of 'w', the `curr` pointer is at the node
            // representing the full word 'w'. Increment its count to mark 'w' as inserted.
            curr->word_count_at_node++;
        }

        return total_pairs;
    }
};

long long Solution::P1 = 31;
long long Solution::M1 = 1e9 + 7;
long long Solution::P2 = 37;
long long Solution::M2 = 1e9 + 9;
std::vector<long long> Solution::powers1;
std::vector<long long> Solution::powers2;
bool Solution::powers_precomputed = false;