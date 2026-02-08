public class Solution {

import java.util.*;

public class Solution {
    public String replaceWords(List<String> dictionary, String sentence) {
        Trie trie = new Trie();
        for (String word : dictionary) {
            trie.insert(word);
        }
        StringBuilder result = new StringBuilder();
        String[] words = sentence.split(" ");
        for (int i = 0; i < words.length; i++) {
            String root = trie.search(words[i]);
            if (i > 0) {
                result.append(" ");
            }
            result.append(root);
        }
        return result.toString();
    }

    static class Trie {
        private TrieNode root;

        public Trie() {
            root = new TrieNode();
        }

        public void insert(String word) {
            TrieNode node = root;
            for (char c : word.toCharArray()) {
                if (!node.children.containsKey(c)) {
                    node.children.put(c, new TrieNode());
                }
                node = node.children.get(c);
            }
            node.isEnd = true;
        }

        public String search(String word) {
            TrieNode node = root;
            StringBuilder prefix = new StringBuilder();
            for (char c : word.toCharArray()) {
                if (!node.children.containsKey(c)) {
                    break;
                }
                node = node.children.get(c);
                prefix.append(c);
                if (node.isEnd) {
                    return prefix.toString();
                }
            }
            return word;
        }
    }

    static class TrieNode {
        Map<Character, TrieNode> children;
        boolean isEnd;

        public TrieNode() {
            children = new HashMap<>();
            isEnd = false;
        }
    }
}
}