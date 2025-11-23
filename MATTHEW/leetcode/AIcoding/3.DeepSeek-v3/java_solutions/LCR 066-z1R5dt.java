class MapSum {
    class TrieNode {
        int val;
        TrieNode[] children;

        public TrieNode() {
            val = 0;
            children = new TrieNode[26];
        }
    }

    private TrieNode root;

    public MapSum() {
        root = new TrieNode();
    }

    public void insert(String key, int val) {
        TrieNode node = root;
        for (char c : key.toCharArray()) {
            if (node.children[c - 'a'] == null) {
                node.children[c - 'a'] = new TrieNode();
            }
            node = node.children[c - 'a'];
        }
        node.val = val;
    }

    public int sum(String prefix) {
        TrieNode node = root;
        for (char c : prefix.toCharArray()) {
            if (node.children[c - 'a'] == null) {
                return 0;
            }
            node = node.children[c - 'a'];
        }
        return dfs(node);
    }

    private int dfs(TrieNode node) {
        if (node == null) {
            return 0;
        }
        int sum = node.val;
        for (TrieNode child : node.children) {
            sum += dfs(child);
        }
        return sum;
    }
}