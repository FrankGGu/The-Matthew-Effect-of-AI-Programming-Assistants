import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class TrieNode {
    TrieNode[] children = new TrieNode[26];
    String word = null;
}

public class Solution {
    private TrieNode root;
    private Set<String> result = new HashSet<>();
    private char[][] board;
    private boolean[][] visited;

    public List<String> findWords(char[][] board, String[] words) {
        this.board = board;
        root = buildTrie(words);
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[0].length; j++) {
                visited = new boolean[board.length][board[0].length];
                backtrack(i, j, root);
            }
        }
        return new ArrayList<>(result);
    }

    private void backtrack(int i, int j, TrieNode node) {
        char ch = board[i][j];
        if (node.children[ch - 'a'] == null) return;
        node = node.children[ch - 'a'];
        if (node.word != null) {
            result.add(node.word);
            node.word = null; // avoid duplication
        }
        visited[i][j] = true;
        for (int x = -1; x <= 1; x++) {
            for (int y = -1; y <= 1; y++) {
                if (Math.abs(x) + Math.abs(y) == 1) {
                    int newX = i + x, newY = j + y;
                    if (newX >= 0 && newX < board.length && newY >= 0 && newY < board[0].length && !visited[newX][newY]) {
                        backtrack(newX, newY, node);
                    }
                }
            }
        }
        visited[i][j] = false;
    }

    private TrieNode buildTrie(String[] words) {
        TrieNode root = new TrieNode();
        for (String word : words) {
            TrieNode node = root;
            for (char c : word.toCharArray()) {
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
            }
            node.word = word;
        }
        return root;
    }
}