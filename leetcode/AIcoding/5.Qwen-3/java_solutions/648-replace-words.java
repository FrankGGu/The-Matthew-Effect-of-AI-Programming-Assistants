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
            if (i > 0) {
                result.append(" ");
            }
            result.append(trie.replace(words[i]));
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
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
            }
            node.isEnd = true;
        }

        public String replace(String word) {
            TrieNode node = root;
            StringBuilder prefix = new StringBuilder();
            for (char c : word.toCharArray()) {
                if (node.children[c - 'a'] == null) {
                    return word;
                }
                node = node.children[c - 'a'];
                prefix.append(c);
                if (node.isEnd) {
                    return prefix.toString();
                }
            }
            return word;
        }

        static class TrieNode {
            TrieNode[] children;
            boolean isEnd;

            public TrieNode() {
                children = new TrieNode[26];
                isEnd = false;
            }
        }
    }
}
}