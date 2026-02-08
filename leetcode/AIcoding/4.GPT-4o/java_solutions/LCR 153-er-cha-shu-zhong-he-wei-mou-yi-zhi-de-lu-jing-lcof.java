import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();
        findPaths(root, targetSum, new ArrayList<>(), result);
        return result;
    }

    private void findPaths(TreeNode node, int remainingSum, List<Integer> path, List<List<Integer>> result) {
        if (node == null) return;

        path.add(node.val);
        if (node.left == null && node.right == null && remainingSum == node.val) {
            result.add(new ArrayList<>(path));
        } else {
            findPaths(node.left, remainingSum - node.val, path, result);
            findPaths(node.right, remainingSum - node.val, path, result);
        }
        path.remove(path.size() - 1);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}