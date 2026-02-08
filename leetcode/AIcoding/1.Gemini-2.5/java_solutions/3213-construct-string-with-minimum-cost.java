import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class TrieNode {
    TrieNode[] children;
    long minCost; // Stores the minimum cost of a word ending at this node

    public TrieNode() {
        children = new TrieNode[26];
        minCost = Long.MAX_VALUE;
    }
}

class Solution {
    public long minimumCost(String target, String[] words, int[] costs, int k) {
        TrieNode root = new TrieNode();

        // Build the Trie with reversed words
        // This allows efficient matching of suffixes of the target string.
        for (int x = 0; x < words.length; x++) {
            String word = words[x];
            long cost = costs[x];
            TrieNode curr = root;
            // Iterate from the end of the word to the beginning to build the reversed word in the Trie
            for (int i = word.length() - 1; i >= 0; i--) {
                char ch = word.charAt(i);
                int idx = ch - 'a';
                if (curr.children[idx] == null) {
                    curr.children[idx] = new TrieNode();
                }
                curr = curr.children[idx];
            }
            // Store the minimum cost for words ending at this node
            curr.minCost = Math.min(curr.minCost, cost);
        }

        int n = target.length();
        long[] dp = new long[n + 1];
        Arrays.fill(dp, Long.MAX_VALUE);
        dp[0] = 0; // Cost to construct an empty string (prefix of length 0) is 0

        for (int i = 1; i <= n; i++) {
            // Option 1: Delete the character target[i-1]
            // If the previous prefix target[0...i-2] could be formed,
            // we can form target[0...i-1] by deleting target[i-1] at cost k.
            if (dp[i-1] != Long.MAX_VALUE) {
                dp[i] = Math.min(dp[i], dp[i-1] + k);
            }

            // Option 2: Match a word ending at target[i-1]
            // We iterate backwards from target[i-1] to target[0] to find potential words
            // that form a suffix of target[0...i-1].
            // The Trie was built with reversed words, so this traversal matches correctly.
            TrieNode curr = root;
            for (int j = i - 1; j >= 0; j--) {
                char ch = target.charAt(j); // This character is the 'j'-th character of target
                int idx = ch - 'a';

                if (curr.children[idx] == null) {
                    // No word in the Trie can be formed by this sequence of characters
                    // (i.e., target[j...i-1] cannot be a word)
                    break;
                }
                curr = curr.children[idx];

                // If a word ends at this Trie node (meaning target[j...i-1] is a valid word)
                if (curr.minCost != Long.MAX_VALUE) {
                    // If the prefix target[0...j-1] could be formed,
                    // we can form target[0...i-1] by appending this word at cost curr.minCost.
                    if (dp[j] != Long.MAX_VALUE) {
                        dp[i] = Math.min(dp[i], dp[j] + curr.minCost);
                    }
                }
            }
        }

        // If dp[n] is still Long.MAX_VALUE, it means target string cannot be formed.
        return dp[n] == Long.MAX_VALUE ? -1 : dp[n];
    }
}