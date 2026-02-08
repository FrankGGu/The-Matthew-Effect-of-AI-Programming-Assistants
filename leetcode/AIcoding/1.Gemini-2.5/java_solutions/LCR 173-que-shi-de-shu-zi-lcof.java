import java.util.Arrays;

class Solution {

    private static class TrieNode {
        TrieNode[] children = new TrieNode[26];
        int count = 0; // Number of words that end at this node
        int prefixCount = 0; // Number of words that have this prefix (including those ending here)
    }

    private TrieNode root = new TrieNode();

    private void insertWords(String[] words) {
        for (String word : words) {
            TrieNode curr = root;
            for (char c : word.toCharArray()) {
                int idx = c - 'a';
                if (curr.children[idx] == null) {
                    curr.children[idx] = new TrieNode();
                }
                curr = curr.children[idx];
            }
            curr.count++;
        }
    }

    private void calculatePrefixCounts(TrieNode node) {
        if (node == null) {
            return;
        }

        for (int i = 0; i < 26; i++) {
            if (node.children[i] != null) {
                calculatePrefixCounts(node.children[i]);
                node.prefixCount += node.children[i].prefixCount;
            }
        }
        node.prefixCount += node.count;
    }

    private long calculateTotalPairs(TrieNode node) {
        if (node == null) {
            return 0;
        }

        long currentPairs = 0;
        if (node.count > 0) {
            currentPairs += (long)node.count * (node.prefixCount - node.count);
        }

        for (int i = 0; i < 26; i++) {
            currentPairs += calculateTotalPairs(node.children[i]);
        }
        return currentPairs;
    }

    public long solve(String[] words) {
        root = new TrieNode(); 
        insertWords(words);
        calculatePrefixCounts(root);
        return calculateTotalPairs(root);
    }
}