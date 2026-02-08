public class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int sum) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();
        dfs(root, sum, 0, currentPath, result);
        return result;
    }

    private void dfs(TreeNode node, int target, int currentSum, List<Integer> currentPath, List<List<Integer>> result) {
        if (node == null) {
            return;
        }
        currentSum += node.val;
        currentPath.add(node.val);
        if (node.left == null && node.right == null) {
            if (currentSum == target) {
                result.add(new ArrayList<>(currentPath));
            }
        } else {
            dfs(node.left, target, currentSum, currentPath, result);
            dfs(node.right, target, currentSum, currentPath, result);
        }
        currentPath.remove(currentPath.size() - 1);
    }
}