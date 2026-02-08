#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <tuple>
#include <functional> // For std::function
#include <limits>   // For std::numeric_limits

struct TrieNode {
    TrieNode* children[26];
    // Stores pairs of {original_word_idx, rank_of_word} for words passing through this node.
    // This list is sorted by original_word_idx, and filtered to keep only "best" candidates
    // (i.e., for a given original_word_idx, it stores the best rank seen up to that index).
    std::vector<std::pair<int, int>> best_words_upto_idx; 

    TrieNode() {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
    }

    // Destructor to free memory
    ~TrieNode() {
        for (int i = 0; i < 26; ++i) {
            delete children[i];
        }
    }
};

class Solution {
public:
    std::vector<std::string> words_orig; // Store original words for string comparisons
    std::vector<int> word_to_rank_map; // Maps original_word_idx to its lexicographical rank

    // Function to build the Trie and post-process each node's candidate list
    void build_trie_and_process_nodes(TrieNode* root, const std::vector<std::string>& words) {
        // Step 1: Populate best_words_upto_idx lists during Trie insertion
        for (int i = 0; i < words.size(); ++i) {
            std::string s = words[i];
            std::reverse(s.begin(), s.end()); // Reverse for suffix Trie

            TrieNode* curr = root;
            for (char ch : s) {
                int char_idx = ch - 'a';
                if (!curr->children[char_idx]) {
                    curr->children[char_idx] = new TrieNode();
                }
                curr = curr->children[char_idx];
                curr->best_words_upto_idx.push_back({i, word_to_rank_map[i]});
            }
        }

        // Step 2: Post-process each node's best_words_upto_idx list
        // Sort by original_word_idx, then filter for prefix minimums of rank
        std::function<void(TrieNode*)> process_node = 
            [&](TrieNode* node) {

            if (node->best_words_upto_idx.empty()) {
                for (int i = 0; i < 26; ++i) {
                    if (node->children[i]) process_node(node->children[i]);
                }
                return;
            }

            // Sort by original_word_idx
            std::sort(node->best_words_upto_idx.begin(), node->best_words_upto_idx.end(), 
                      [](const auto& a, const auto& b) {
                return a.first < b.first;
            });

            // Filter for "best" candidates (prefix minimums of rank)
            std::vector<std::pair<int, int>> filtered_list;
            int min_rank_so_far = std::numeric_limits<int>::max(); // Initialize with max value

            for (auto& p : node->best_words_upto_idx) {
                // If current word has a strictly better rank, add it
                if (p.second < min_rank_so_far) {
                    min_rank_so_far = p.second;
                    filtered_list.push_back(p);
                }
                // If ranks are equal, we prefer the one with smaller original_word_idx.
                // Since the list is already sorted by original_word_idx, the first one encountered
                // for a given rank is implicitly the one with the smallest original_word_idx.
                // Subsequent words with the same rank but larger original_word_idx are not added.
            }
            node->best_words_upto_idx = filtered_list;

            for (int i = 0; i < 26; ++i) {
                if (node->children[i]) process_node(node->children[i]);
            }
        };

        process_node(root);
    }

    std::vector<int> longestCommonSuffixQueries(std::vector<std::string>& words, std::vector<std::vector<std::string>>& queries) {
        words_orig = words; // Keep a copy of original words for comparisons

        // Step 1: Precompute lexicographical ranks for all words
        std::vector<std::pair<std::string, int>> sorted_words_for_rank;
        sorted_words_for_rank.reserve(words.size());
        for (int i = 0; i < words.size(); ++i) {
            sorted_words_for_rank.push_back({words[i], i});
        }
        std::sort(sorted_words_for_rank.begin(), sorted_words_for_rank.end());

        word_to_rank_map.resize(words.size());
        for (int i = 0; i < sorted_words_for_rank.size(); ++i) {
            word_to_rank_map[sorted_words_for_rank[i].second] = i;
        }

        // Step 2: Build Trie and post-process nodes
        TrieNode* root = new TrieNode();
        build_trie_and_process_nodes(root, words);

        // Step 3: Prepare queries for offline processing
        std::vector<std::tuple<std::string, int, int>> indexed_queries; // {queryWord, queryIndex, original_query_idx}
        for (int i = 0; i < queries.size(); ++i) {
            indexed_queries.emplace_back(queries[i][0], std::stoi(queries[i][1]), i);
        }

        // Sort queries by queryIndex (the upper bound for 'j')
        std::sort(indexed_queries.begin(), indexed_queries.end(), 
                  [](const auto& a, const auto& b) {
            return std::get<1>(a) < std::get<1>(b);
        });

        std::vector<int> results(queries.size());

        // Step 4: Process queries
        for (const auto& q_tuple : indexed_queries) {
            std::string query_word = std::get<0>(q_tuple);
            int query_idx_limit = std::get<1>(q_tuple);
            int original_query_idx = std::get<2>(q_tuple);

            std::string reversed_query_word = query_word;
            std::reverse(reversed_query_word.begin(), reversed_query_word.end());

            int max_suffix_len = 0;
            int best_word_original_idx = -1;
            int best_word_rank = std::numeric_limits<int>::max(); // Initialize with max rank

            TrieNode* curr = root;
            for (int len = 0; len < reversed_query_word.length(); ++len) {
                char ch = reversed_query_word[len];
                int char_idx = ch - 'a';
                if (!curr->children[char_idx]) {
                    break; // No more common suffix
                }
                curr = curr->children[char_idx];

                // Current node represents a common suffix of length (len + 1)
                // Find the best word in curr->best_words_upto_idx that satisfies original_word_idx <= query_idx_limit
                auto& candidates = curr->best_words_upto_idx;

                // Binary search for the first element whose original_word_idx is > query_idx_limit
                // This finds the insertion point, so we need to decrement to get the largest <= query_idx_limit
                auto it = std::upper_bound(candidates.begin(), candidates.end(), 
                                           std::make_pair(query_idx_limit, std::numeric_limits<int>::max()));

                if (it != candidates.begin()) {
                    --it; // 'it' now points to the best candidate for original_word_idx <= query_idx_limit
                    int current_candidate_idx = it->first;
                    int current_candidate_rank = it->second;

                    // Compare with current best result based on problem criteria:
                    // 1. Longest common suffix
                    // 2. Lexicographically smallest word
                    // 3. Smallest index j
                    if ((len + 1) > max_suffix_len) {
                        max_suffix_len = (len + 1);
                        best_word_original_idx = current_candidate_idx;
                        best_word_rank = current_candidate_rank;
                    } else if ((len + 1) == max_suffix_len) {
                        if (current_candidate_rank < best_word_rank) {
                            best_word_original_idx = current_candidate_idx;
                            best_word_rank = current_candidate_rank;
                        } else if (current_candidate_rank == best_word_rank) {
                            if (current_candidate_idx < best_word_original_idx) {
                                best_word_original_idx = current_candidate_idx;
                            }
                        }
                    }
                }
            }
            results[original_query_idx] = best_word_original_idx;
        }

        delete root; // Clean up Trie memory
        return results;
    }
};