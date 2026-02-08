public class Solution {

import java.util.*;

public class Solution {
    private class TrieNode {
        Map<Character, TrieNode> children;
        int index;

        public TrieNode() {
            children = new HashMap<>();
            index = -1;
        }
    }

    private TrieNode root;

    public Solution(String[] words) {
        root = new TrieNode();
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            TrieNode node = root;
            for (char c : word.toCharArray()) {
                if (!node.children.containsKey(c)) {
                    node.children.put(c, new TrieNode());
                }
                node = node.children.get(c);
            }
            node.index = i;
        }
    }

    public int find(String prefix) {
        TrieNode node = root;
        for (char c : prefix.toCharArray()) {
            if (!node.children.containsKey(c)) {
                return -1;
            }
            node = node.children.get(c);
        }
        return node.index;
    }

    public int search(String prefix, String suffix) {
        int index = find(prefix);
        if (index == -1) {
            return -1;
        }
        String word = "";
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            if (root.children.containsKey(c)) {
                word = "";
                TrieNode node = root.children.get(c);
                if (node.index != -1) {
                    word = getWord(node, c);
                    if (word.endsWith(suffix)) {
                        return node.index;
                    }
                }
            }
        }
        return -1;
    }

    private String getWord(TrieNode node, char c) {
        StringBuilder sb = new StringBuilder();
        sb.append(c);
        while (node.children.size() == 1 && node.index == -1) {
            for (char nextC : node.children.keySet()) {
                node = node.children.get(nextC);
                sb.append(nextC);
            }
        }
        return sb.toString();
    }

    public int f(String prefix, String suffix) {
        int index = find(prefix);
        if (index == -1) {
            return -1;
        }
        String word = "";
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            if (root.children.containsKey(c)) {
                TrieNode node = root.children.get(c);
                if (node.index != -1) {
                    word = getWord(node, c);
                    if (word.endsWith(suffix)) {
                        return node.index;
                    }
                }
            }
        }
        return -1;
    }
}
}