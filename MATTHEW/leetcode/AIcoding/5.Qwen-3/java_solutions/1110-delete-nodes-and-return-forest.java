public class Solution {

import java.util.*;

public class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] toDelete) {
        Set<Integer> deleteSet = new HashSet<>();
        for (int val : toDelete) {
            deleteSet.add(val);
        }
        List<TreeNode> result = new ArrayList<>();
        helper(root, deleteSet, result, true);
        return result;
    }

    private TreeNode helper(TreeNode node, Set<Integer> deleteSet, List<TreeNode> result, boolean isRoot) {
        if (node == null) {
            return null;
        }
        boolean delete = deleteSet.contains(node.val);
        if (delete) {
            node.left = helper(node.left, deleteSet, result, true);
            node.right = helper(node.right, deleteSet, result, true);
            return null;
        } else {
            node.left = helper(node.left, deleteSet, result, false);
            node.right = helper(node.right, deleteSet, result, false);
            if (isRoot) {
                result.add(node);
            }
            return node;
        }
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}