class Solution {
    public long countPrefixSuffixPairs(String[] words) {
        long count = 0;
        TrieNode root = new TrieNode();
        for (String word : words) {
            count += searchAndInsert(root, word);
        }
        return count;
    }

    private int searchAndInsert(TrieNode root, String word) {
        int res = 0;
        TrieNode node = root;
        int n = word.length();
        for (int i = 0; i < n; i++) {
            char c = word.charAt(i);
            if (node.children[c - 'a'] == null) {
                node.children[c - 'a'] = new TrieNode();
            }
            node = node.children[c - 'a'];
            if (node.isEnd && word.endsWith(word.substring(0, i + 1))) {
                res += node.count;
            }
        }
        node.isEnd = true;
        node.count++;
        return res;
    }

    class TrieNode {
        TrieNode[] children;
        boolean isEnd;
        int count;

        public TrieNode() {
            children = new TrieNode[26];
            isEnd = false;
            count = 0;
        }
    }
}