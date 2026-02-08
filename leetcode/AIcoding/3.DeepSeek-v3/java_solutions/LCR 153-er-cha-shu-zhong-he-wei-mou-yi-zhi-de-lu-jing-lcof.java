class Solution {
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> path = new ArrayList<>();
        dfs(root, targetSum, path, result);
        return result;
    }

    private void dfs(TreeNode node, int target, List<Integer> path, List<List<Integer>> result) {
        if (node == null) return;

        path.add(node.val);
        target -= node.val;

        if (node.left == null && node.right == null && target == 0) {
            result.add(new ArrayList<>(path));
        } else {
            dfs(node.left, target, path, result);
            dfs(node.right, target, path, result);
        }

        path.remove(path.size() - 1);
    }
}