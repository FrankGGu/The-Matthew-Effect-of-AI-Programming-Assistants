import java.util.HashMap;
import java.util.Map;

class Solution {

    private static class TrieNode {
        Map<Character, TrieNode> children;

        TrieNode() {
            children = new HashMap<>();
        }
    }

    public int minimumLengthEncoding(String[] words) {
        TrieNode root = new TrieNode();

        for (String word : words) {
            String reversedWord = new StringBuilder(word).reverse().toString();
            TrieNode current = root;
            for (char ch : reversedWord.toCharArray()) {
                current.children.putIfAbsent(ch, new TrieNode());
                current = current.children.get(ch);
            }
        }

        return dfs(root, 0);
    }

    private int dfs(TrieNode node, int depth) {
        int totalLength = 0;
        boolean isLeaf = true;

        for (TrieNode child : node.children.values()) {
            isLeaf = false;
            totalLength += dfs(child, depth + 1);
        }

        if (isLeaf) {
            return depth + 1;
        }

        return totalLength;
    }
}