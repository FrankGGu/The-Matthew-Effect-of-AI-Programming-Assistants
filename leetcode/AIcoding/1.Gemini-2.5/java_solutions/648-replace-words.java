import java.util.List;
import java.util.ArrayList;

class Solution {

    private static class TrieNode {
        TrieNode[] children;
        boolean isEndOfWord;

        public TrieNode() {
            children = new TrieNode[26];
            isEndOfWord = false;
        }
    }

    private TrieNode root;

    public Solution() {
        root = new TrieNode();
    }

    public void insert(String word) {
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

    public String findShortestRoot(String word) {
        TrieNode current = root;
        StringBuilder prefix = new StringBuilder();
        for (char c : word.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                return word;
            }
            current = current.children[index];
            prefix.append(c);
            if (current.isEndOfWord) {
                return prefix.toString();
            }
        }
        return word;
    }

    public String replaceWords(List<String> dictionary, String sentence) {
        Solution trie = new Solution();
        for (String rootWord : dictionary) {
            trie.insert(rootWord);
        }

        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            result.append(trie.findShortestRoot(words[i]));
            if (i < words.length - 1) {
                result.append(" ");
            }
        }

        return result.toString();
    }
}