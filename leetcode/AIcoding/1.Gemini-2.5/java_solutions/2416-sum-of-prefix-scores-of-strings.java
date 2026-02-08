class TrieNode {
    TrieNode[] children = new TrieNode[26];
    int count = 0; // Stores the number of words in the input array that have the prefix ending at this node.
}

class Solution {
    public int[] sumPrefixScores(String[] words) {
        TrieNode root = new TrieNode();

        // Step 1: Build the Trie and populate counts for each prefix.
        // For each word, traverse its characters. For every node visited (representing a prefix),
        // increment its count. This count indicates how many words in the input array
        // start with this specific prefix.
        for (String word : words) {
            TrieNode curr = root;
            for (char c : word.toCharArray()) {
                int index = c - 'a';
                if (curr.children[index] == null) {
                    curr.children[index] = new TrieNode();
                }
                curr = curr.children[index];
                curr.count++; 
            }
        }

        // Step 2: Calculate the prefix score for each word.
        // For each word words[i], traverse it in the Trie.
        // The score for words[i] is the sum of the 'count' values of all nodes
        // that represent prefixes of words[i].
        int[] ans = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            long currentScore = 0; // Use long to prevent potential overflow during summation
            TrieNode curr = root;
            for (char c : word.toCharArray()) {
                int index = c - 'a';
                // The node for this character (and thus this prefix) must exist
                // because all words were inserted into the Trie in Step 1.
                curr = curr.children[index]; 
                currentScore += curr.count; 
            }
            ans[i] = (int) currentScore;
        }

        return ans;
    }
}