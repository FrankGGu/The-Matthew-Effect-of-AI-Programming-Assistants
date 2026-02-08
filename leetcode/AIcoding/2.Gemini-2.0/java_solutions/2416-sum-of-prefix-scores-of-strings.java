class Solution {
    public int[] sumPrefixScores(String[] words) {
        TrieNode root = new TrieNode();
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

        int[] result = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            int score = 0;
            TrieNode curr = root;
            for (char c : word.toCharArray()) {
                int index = c - 'a';
                curr = curr.children[index];
                score += curr.count;
            }
            result[i] = score;
        }

        return result;
    }

    private class TrieNode {
        TrieNode[] children;
        int count;

        public TrieNode() {
            children = new TrieNode[26];
            count = 0;
        }
    }
}