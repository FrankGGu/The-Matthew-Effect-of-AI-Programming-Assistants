import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        List<TreeNode> result = new ArrayList<>();
        boolean[] toDelete = new boolean[1001];
        for (int val : to_delete) {
            toDelete[val] = true;
        }
        if (deleteNodes(root, toDelete, result)) {
            result.add(root);
        }
        return result;
    }

    private boolean deleteNodes(TreeNode node, boolean[] toDelete, List<TreeNode> result) {
        if (node == null) return false;

        boolean isDeleted = deleteNodes(node.left, toDelete, result) || deleteNodes(node.right, toDelete, result);

        if (toDelete[node.val]) {
            if (node.left != null) result.add(node.left);
            if (node.right != null) result.add(node.right);
            return true;
        }

        return isDeleted;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}