public class Solution {

import java.util.*;

public class Solution {
    public List<List<String>> printTree(TreeNode root) {
        int height = getHeight(root);
        int width = (int) Math.pow(2, height) - 1;
        List<List<String>> result = new ArrayList<>();
        for (int i = 0; i < height; i++) {
            result.add(new ArrayList<>(Collections.nCopies(width, "")));
        }
        fillTree(result, root, 0, 0, width - 1);
        return result;
    }

    private int getHeight(TreeNode node) {
        if (node == null) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }

    private void fillTree(List<List<String>> result, TreeNode node, int level, int left, int right) {
        if (node == null) return;
        int mid = (left + right) / 2;
        result.get(level).set(mid, String.valueOf(node.val));
        fillTree(result, node.left, level + 1, left, mid - 1);
        fillTree(result, node.right, level + 1, mid + 1, right);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}