class TrieNode {
    TrieNode[] children;
    int count; // Number of words that end at this node

    public TrieNode() {
        children = new TrieNode[26];
        count = 0;
    }
}

class Solution {
    // Using two hash functions to reduce collision probability
    private static final long P1 = 31; // Prime base for hash function 1
    private static final long M1 = 1_000_000_007L; // Modulo for hash function 1
    private static final long P2 = 53; // Prime base for hash function 2
    private static final long M2 = 1_000_000_009L; // Modulo for hash function 2

    public long countPrefixSuffixPairs(String[] words) {
        long totalPairs = 0;
        TrieNode root = new TrieNode();

        for (String word : words) {
            int n = word.length();

            // Precompute prefix hashes for the current word
            // prefix_h[k] stores the hash of word.substring(0, k+1)
            long[] prefix_h1 = new long[n];
            long[] prefix_h2 = new long[n];
            long current_h1 = 0;
            long current_h2 = 0;
            for (int k = 0; k < n; k++) {
                int char_val = word.charAt(k) - 'a' + 1;
                current_h1 = (current_h1 * P1 + char_val) % M1;
                current_h2 = (current_h2 * P2 + char_val) % M2;
                prefix_h1[k] = current_h1;
                prefix_h2[k] = current_h2;
            }

            // Precompute suffix hashes for the current word
            // suffix_h[k] stores the hash of word.substring(n-(k+1), n) (suffix of length k+1)
            long[] suffix_h1 = new long[n];
            long[] suffix_h2 = new long[n];
            current_h1 = 0;
            current_h2 = 0;
            long power1 = 1; // P1^0, P1^1, P1^2, ...
            long power2 = 1; // P2^0, P2^1, P2^2, ...
            for (int k = 0; k < n; k++) { // k is length-1, so k+1 is the length of the suffix
                // Character from the end of the word, for building suffix hash
                int char_val = word.charAt(n - 1 - k) - 'a' + 1; 
                current_h1 = (current_h1 + char_val * power1) % M1;
                current_h2 = (current_h2 + char_val * power2) % M2;
                power1 = (power1 * P1) % M1;
                power2 = (power2 * P2) % M2;
                suffix_h1[k] = current_h1;
                suffix_h2[k] = current_h2;
            }

            TrieNode curr = root;
            for (int k = 0; k < n; k++) {
                char c = word.charAt(k);
                if (curr.children[c - 'a'] == null) {
                    curr.children[c - 'a'] = new TrieNode();
                }
                curr = curr.children[c - 'a'];

                // At this point, `curr` represents the prefix `word.substring(0, k+1)`.
                // We need to check if this prefix is also a suffix of `word`.
                // This means `word.substring(0, k+1)` must be equal to `word.substring(n-(k+1), n)`.
                // We use the precomputed hashes for this check.
                if (prefix_h1[k] == suffix_h1[k] && prefix_h2[k] == suffix_h2[k]) {
                    totalPairs += curr.count;
                }
            }
            // After iterating through all prefixes of `word`, we have fully traversed `word` in the Trie.
            // The final `curr` node represents the full `word`. Increment its `count` to mark it as an existing word.
            curr.count++;
        }

        return totalPairs;
    }
}