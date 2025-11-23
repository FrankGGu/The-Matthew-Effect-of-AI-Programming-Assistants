class WordFilter {

    TrieNode trie;
    String[] words;

    public WordFilter(String[] words) {
        trie = new TrieNode();
        this.words = words;

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            String combined = word + "{" + word;
            for (int j = 0; j < word.length(); j++) {
                insert(combined.substring(j), i);
            }
        }
    }

    public int f(String prefix, String suffix) {
        return find(suffix + "{" + prefix);
    }

    private void insert(String word, int index) {
        TrieNode node = trie;
        for (char c : word.toCharArray()) {
            if (node.children[c - 'a'] == null) {
                node.children[c - 'a'] = new TrieNode();
            }
            node = node.children[c - 'a'];
            node.index = index;
        }
    }

    private int find(String word) {
        TrieNode node = trie;
        for (char c : word.toCharArray()) {
            if (node.children[c - 'a'] == null) {
                return -1;
            }
            node = node.children[c - 'a'];
        }
        return node.index;
    }

    class TrieNode {
        TrieNode[] children;
        int index;

        public TrieNode() {
            children = new TrieNode[27];
            index = -1;
        }
    }
}