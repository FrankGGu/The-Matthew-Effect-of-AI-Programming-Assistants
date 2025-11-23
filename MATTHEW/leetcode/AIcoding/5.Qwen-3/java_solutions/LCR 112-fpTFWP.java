public class Solution {

import java.util.*;

public class Solution {
    private int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    private int rows;
    private int cols;
    private int[][] memo;

    public int longestIncreasingPath(TreeNode root) {
        if (root == null) return 0;
        rows = 1;
        cols = 1;
        // Convert the tree to a matrix
        List<List<Integer>> matrix = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> row = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                row.add(node.val);
                if (node.left != null) queue.add(node.left);
                if (node.right != null) queue.add(node.right);
            }
            matrix.add(row);
        }
        rows = matrix.size();
        cols = matrix.get(0).size();
        memo = new int[rows][cols];
        int maxPath = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxPath = Math.max(maxPath, dfs(matrix, i, j));
            }
        }
        return maxPath;
    }

    private int dfs(List<List<Integer>> matrix, int i, int j) {
        if (memo[i][j] != 0) return memo[i][j];
        int maxLen = 1;
        for (int[] dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && matrix.get(ni).get(nj) > matrix.get(i).get(j)) {
                int len = 1 + dfs(matrix, ni, nj);
                maxLen = Math.max(maxLen, len);
            }
        }
        memo[i][j] = maxLen;
        return maxLen;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}
}