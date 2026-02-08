import java.util.ArrayList;
import java.util.List;

class Solution {

    class TrieNode {
        TrieNode[] children = new TrieNode[26];
        String word = null; 
    }

    private TrieNode buildTrie(String[] words) {
        TrieNode root = new TrieNode();
        for (String word : words) {
            TrieNode curr = root;
            for (char c : word.toCharArray()) {
                int idx = c - 'a';
                if (curr.children[idx] == null) {
                    curr.children[idx] = new TrieNode();
                }
                curr = curr.children[idx];
            }
            curr.word = word; 
        }
        return root;
    }

    private int m, n;
    private char[][] board;
    private TrieNode trieRoot;
    private List<String> result;

    public List<String> findWords(char[][] board, String[] words) {
        this.board = board;
        this.m = board.length;
        this.n = board[0].length;
        this.trieRoot = buildTrie(words);
        this.result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dfs(i, j, trieRoot);
            }
        }

        return result;
    }

    private void dfs(int r, int c, TrieNode node) {
        if (r < 0 || r >= m || c < 0 || c >= n) {
            return;
        }

        char ch = board[r][c];
        if (ch == '#') { 
            return;
        }

        int idx = ch - 'a';
        if (node.children[idx] == null) { 
            return;
        }

        TrieNode nextNode = node.children[idx];

        if (nextNode.word != null) {
            result.add(nextNode.word);
            nextNode.word = null; 
        }

        board[r][c] = '#';

        dfs(r + 1, c, nextNode);
        dfs(r - 1, c, nextNode);
        dfs(r, c + 1, nextNode);
        dfs(r, c - 1, nextNode);

        board[r][c] = ch;
    }
}