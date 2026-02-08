import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();
        findPaths(root, targetSum, currentPath, result);
        return result;
    }

    private void findPaths(TreeNode node, int remainingSum, List<Integer> currentPath, List<List<Integer>> result) {
        if (node == null) {
            return;
        }

        currentPath.add(node.val);
        remainingSum -= node.val;

        if (node.left == null && node.right == null) { // It's a leaf node
            if (remainingSum == 0) {
                result.add(new ArrayList<>(currentPath));
            }
        } else {
            // Recurse for children
            findPaths(node.left, remainingSum, currentPath, result);
            findPaths(node.right, remainingSum, currentPath, result);
        }

        // Backtrack: remove the current node's value before returning
        currentPath.remove(currentPath.size() - 1);
    }
}