class WordFilter {
    private TrieNode root;

    public WordFilter(String[] words) {
        root = new TrieNode();
        for (int weight = 0; weight < words.length; weight++) {
            String word = words[weight];
            for (int i = 0; i <= word.length(); i++) {
                String prefix = word.substring(0, i);
                root.insert(prefix, weight);
            }
        }
    }

    public int f(String prefix, String suffix) {
        return root.search(prefix, suffix);
    }

    private static class TrieNode {
        private TrieNode[] children;
        private List<Integer> weights;

        public TrieNode() {
            children = new TrieNode[27];
            weights = new ArrayList<>();
        }

        public void insert(String prefix, int weight) {
            TrieNode node = this;
            for (char c : prefix.toCharArray()) {
                int index = c - 'a';
                if (node.children[index] == null) {
                    node.children[index] = new TrieNode();
                }
                node = node.children[index];
                node.weights.add(weight);
            }
        }

        public int search(String prefix, String suffix) {
            TrieNode node = this;
            for (char c : prefix.toCharArray()) {
                int index = c - 'a';
                if (node.children[index] == null) {
                    return -1;
                }
                node = node.children[index];
            }
            for (int i = node.weights.size() - 1; i >= 0; i--) {
                int weight = node.weights.get(i);
                if (weight < suffix.length() && suffix.equals(prefix.substring(0, suffix.length()))) {
                    return weight;
                }
            }
            return -1;
        }
    }
}