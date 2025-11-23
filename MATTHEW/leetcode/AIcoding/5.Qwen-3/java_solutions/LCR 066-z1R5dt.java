public class Solution {

import java.util.*;

public class MapSum {
    private class TrieNode {
        Map<Character, TrieNode> children;
        int value;

        public TrieNode() {
            children = new HashMap<>();
            value = 0;
        }
    }

    private TrieNode root;

    public MapSum() {
        root = new TrieNode();
    }

    public void insert(String key, int val) {
        TrieNode node = root;
        for (char c : key.toCharArray()) {
            if (!node.children.containsKey(c)) {
                node.children.put(c, new TrieNode());
            }
            node = node.children.get(c);
        }
        node.value = val;
    }

    public int sum(String prefix) {
        TrieNode node = root;
        for (char c : prefix.toCharArray()) {
            if (!node.children.containsKey(c)) {
                return 0;
            }
            node = node.children.get(c);
        }
        return dfs(node);
    }

    private int dfs(TrieNode node) {
        int total = node.value;
        for (TrieNode child : node.children.values()) {
            total += dfs(child);
        }
        return total;
    }
}
}