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
        printTreeHelper(root, 0, 0, width - 1, result);
        return result;
    }

    private void printTreeHelper(TreeNode node, int level, int left, int right, List<List<String>> result) {
        if (node == null) return;
        int mid = (left + right) / 2;
        result.get(level).set(mid, String.valueOf(node.val));
        printTreeHelper(node.left, level + 1, left, mid - 1, result);
        printTreeHelper(node.right, level + 1, mid + 1, right, result);
    }

    private int getHeight(TreeNode root) {
        if (root == null) return 0;
        return 1 + Math.max(getHeight(root.left), getHeight(root.right));
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}
}