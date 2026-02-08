import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();
        pathSumHelper(root, targetSum, currentPath, result);
        return result;
    }

    private void pathSumHelper(TreeNode root, int targetSum, List<Integer> currentPath, List<List<Integer>> result) {
        if (root == null) {
            return;
        }

        currentPath.add(root.val);
        targetSum -= root.val;

        if (root.left == null && root.right == null && targetSum == 0) {
            result.add(new ArrayList<>(currentPath));
        } else {
            pathSumHelper(root.left, targetSum, currentPath, result);
            pathSumHelper(root.right, targetSum, currentPath, result);
        }

        currentPath.remove(currentPath.size() - 1);
    }

    public class TreeNode {
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