public class Solution {

import java.util.*;

public class MagicDictionary {
    private TrieNode root;

    public MagicDictionary() {
        root = new TrieNode();
    }

    public void buildDict(String[] dictionary) {
        for (String word : dictionary) {
            TrieNode node = root;
            for (char c : word.toCharArray()) {
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
            }
            node.isEnd = true;
        }
    }

    public boolean search(String searchWord) {
        return dfs(searchWord, 0, root, false);
    }

    private boolean dfs(String word, int index, TrieNode node, boolean isModified) {
        if (index == word.length()) {
            return isModified && node.isEnd;
        }

        char c = word.charAt(index);
        if (node.children[c - 'a'] != null) {
            if (dfs(word, index + 1, node.children[c - 'a'], isModified)) {
                return true;
            }
        }

        if (!isModified) {
            for (int i = 0; i < 26; i++) {
                if (node.children[i] != null && i != c - 'a') {
                    if (dfs(word, index + 1, node.children[i], true)) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    private static class TrieNode {
        TrieNode[] children = new TrieNode[26];
        boolean isEnd;
    }
}
}