import java.util.*;

public class Solution {
    public List<List<String>> printTree(TreeNode root) {
        if (root == null) return new ArrayList<>();
        int height = getHeight(root);
        int width = (1 << height) - 1;
        List<List<String>> result = new ArrayList<>();

        for (int i = 0; i < height; i++) {
            List<String> row = new ArrayList<>(Collections.nCopies(width, ""));
            result.add(row);
        }

        fill(result, root, 0, 0, width - 1);
        return result;
    }

    private void fill(List<List<String>> result, TreeNode node, int depth, int left, int right) {
        if (node == null) return;
        int mid = left + (right - left) / 2;
        result.get(depth).set(mid, String.valueOf(node.val));
        fill(result, node.left, depth + 1, left, mid - 1);
        fill(result, node.right, depth + 1, mid + 1, right);
    }

    private int getHeight(TreeNode node) {
        if (node == null) return 0;
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}