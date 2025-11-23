public class Solution {

import java.util.*;

public class StreamOfCharacters {
    private TrieNode root;
    private List<Character> stream;

    public StreamOfCharacters(String[] words) {
        root = new TrieNode();
        stream = new ArrayList<>();
        for (String word : words) {
            insert(word);
        }
    }

    private void insert(String word) {
        TrieNode node = root;
        for (int i = word.length() - 1; i >= 0; i--) {
            char c = word.charAt(i);
            if (!node.children.containsKey(c)) {
                node.children.put(c, new TrieNode());
            }
            node = node.children.get(c);
        }
        node.isEnd = true;
    }

    public boolean query(char letter) {
        stream.add(letter);
        TrieNode node = root;
        for (int i = stream.size() - 1; i >= 0; i--) {
            char c = stream.get(i);
            if (!node.children.containsKey(c)) {
                return false;
            }
            node = node.children.get(c);
            if (node.isEnd) {
                return true;
            }
        }
        return false;
    }

    private class TrieNode {
        Map<Character, TrieNode> children;
        boolean isEnd;

        public TrieNode() {
            children = new HashMap<>();
            isEnd = false;
        }
    }
}
}