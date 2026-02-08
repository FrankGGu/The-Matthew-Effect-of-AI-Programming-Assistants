import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        List<TreeNode> result = new ArrayList<>();
        Set<Integer> deleteSet = new HashSet<>();
        for (int val : to_delete) {
            deleteSet.add(val);
        }

        root = helper(root, deleteSet, result);
        if (root != null) {
            result.add(root);
        }

        return result;
    }

    private TreeNode helper(TreeNode node, Set<Integer> deleteSet, List<TreeNode> result) {
        if (node == null) {
            return null;
        }

        node.left = helper(node.left, deleteSet, result);
        node.right = helper(node.right, deleteSet, result);

        if (deleteSet.contains(node.val)) {
            if (node.left != null) {
                result.add(node.left);
            }
            if (node.right != null) {
                result.add(node.right);
            }
            return null;
        }

        return node;
    }
}