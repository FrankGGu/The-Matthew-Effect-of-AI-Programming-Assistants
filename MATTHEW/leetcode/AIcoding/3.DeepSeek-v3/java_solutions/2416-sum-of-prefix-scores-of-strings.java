class Solution {
    class TrieNode {
        TrieNode[] children;
        int count;

        public TrieNode() {
            children = new TrieNode[26];
            count = 0;
        }
    }

    public int[] sumPrefixScores(String[] words) {
        TrieNode root = new TrieNode();
        for (String word : words) {
            TrieNode node = root;
            for (char c : word.toCharArray()) {
                int idx = c - 'a';
                if (node.children[idx] == null) {
                    node.children[idx] = new TrieNode();
                }
                node = node.children[idx];
                node.count++;
            }
        }

        int[] res = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            TrieNode node = root;
            int sum = 0;
            for (char c : word.toCharArray()) {
                int idx = c - 'a';
                node = node.children[idx];
                sum += node.count;
            }
            res[i] = sum;
        }
        return res;
    }
}