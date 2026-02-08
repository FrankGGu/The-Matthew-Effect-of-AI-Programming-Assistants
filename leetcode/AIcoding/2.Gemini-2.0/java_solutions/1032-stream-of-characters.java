class StreamChecker {

    class TrieNode {
        TrieNode[] children = new TrieNode[26];
        boolean isWord;
    }

    TrieNode root;
    StringBuilder sb;

    public StreamChecker(String[] words) {
        root = new TrieNode();
        sb = new StringBuilder();

        for (String word : words) {
            TrieNode node = root;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                int index = c - 'a';
                if (node.children[index] == null) {
                    node.children[index] = new TrieNode();
                }
                node = node.children[index];
            }
            node.isWord = true;
        }
    }

    public boolean query(char letter) {
        sb.append(letter);
        TrieNode node = root;
        for (int i = sb.length() - 1; i >= 0; i--) {
            char c = sb.charAt(i);
            int index = c - 'a';
            if (node.children[index] == null) {
                return false;
            }
            node = node.children[index];
            if (node.isWord) {
                return true;
            }
        }
        return false;
    }
}