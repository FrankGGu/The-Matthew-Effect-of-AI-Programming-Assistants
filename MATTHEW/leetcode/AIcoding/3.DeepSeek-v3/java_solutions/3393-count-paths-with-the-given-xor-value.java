class Solution {
    public int solve(TreeNode root, int target) {
        Map<Integer, Integer> prefix = new HashMap<>();
        prefix.put(0, 1);
        return dfs(root, 0, target, prefix);
    }

    private int dfs(TreeNode node, int currentXor, int target, Map<Integer, Integer> prefix) {
        if (node == null) {
            return 0;
        }
        currentXor ^= node.val;
        int res = prefix.getOrDefault(currentXor ^ target, 0);
        prefix.put(currentXor, prefix.getOrDefault(currentXor, 0) + 1);
        res += dfs(node.left, currentXor, target, prefix);
        res += dfs(node.right, currentXor, target, prefix);
        prefix.put(currentXor, prefix.get(currentXor) - 1);
        return res;
    }
}