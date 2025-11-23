class StreamChecker {
    private class TrieNode {
        TrieNode[] children = new TrieNode[26];
        boolean isEnd;
    }

    private TrieNode root;
    private StringBuilder stream;

    public StreamChecker(String[] words) {
        root = new TrieNode();
        for (String word : words) {
            TrieNode node = root;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
            }
            node.isEnd = true;
        }
        stream = new StringBuilder();
    }

    public boolean query(char letter) {
        stream.append(letter);
        TrieNode node = root;
        for (int i = stream.length() - 1; i >= 0; i--) {
            char c = stream.charAt(i);
            if (node.children[c - 'a'] == null) {
                return false;
            }
            node = node.children[c - 'a'];
            if (node.isEnd) {
                return true;
            }
        }
        return false;
    }
}