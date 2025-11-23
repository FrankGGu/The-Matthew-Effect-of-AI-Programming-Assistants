class WordDictionary {

    private TrieNode root;

    private class TrieNode {
        TrieNode[] children;
        boolean isEndOfWord;

        TrieNode() {
            children = new TrieNode[26];
            isEndOfWord = false;
        }
    }

    public WordDictionary() {
        root = new TrieNode();
    }

    public void addWord(String word) {
        TrieNode current = root;
        for (char c : word.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                current.children[index] = new TrieNode();
            }
            current = current.children[index];
        }
        current.isEndOfWord = true;
    }

    public boolean search(String word) {
        return searchHelper(word, 0, root);
    }

    private boolean searchHelper(String word, int index, TrieNode current) {
        if (current == null) {
            return false;
        }

        if (index == word.length()) {
            return current.isEndOfWord;
        }

        char c = word.charAt(index);

        if (c == '.') {
            for (int i = 0; i < 26; i++) {
                if (current.children[i] != null) {
                    if (searchHelper(word, index + 1, current.children[i])) {
                        return true;
                    }
                }
            }
            return false;
        } else {
            int charIndex = c - 'a';
            if (current.children[charIndex] == null) {
                return false;
            }
            return searchHelper(word, index + 1, current.children[charIndex]);
        }
    }
}