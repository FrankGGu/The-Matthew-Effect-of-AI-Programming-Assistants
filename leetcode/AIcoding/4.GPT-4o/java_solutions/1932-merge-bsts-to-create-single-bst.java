import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public TreeNode mergeTrees(TreeNode[] trees) {
        List<Integer> values = new ArrayList<>();
        for (TreeNode root : trees) {
            inorderTraversal(root, values);
        }
        Collections.sort(values);
        return sortedArrayToBST(values.toArray(new Integer[0]));
    }

    private void inorderTraversal(TreeNode node, List<Integer> values) {
        if (node == null) return;
        inorderTraversal(node.left, values);
        values.add(node.val);
        inorderTraversal(node.right, values);
    }

    private TreeNode sortedArrayToBST(Integer[] values) {
        return buildTree(values, 0, values.length - 1);
    }

    private TreeNode buildTree(Integer[] values, int left, int right) {
        if (left > right) return null;
        int mid = left + (right - left) / 2;
        TreeNode node = new TreeNode(values[mid]);
        node.left = buildTree(values, left, mid - 1);
        node.right = buildTree(values, mid + 1, right);
        return node;
    }
}