class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        return dfs(root, targetSum, new HashMap<>());
    }

    private int dfs(TreeNode node, long target, HashMap<Long, Integer> prefixSum) {
        if (node == null) return 0;

        target -= node.val;
        int count = prefixSum.getOrDefault(target, 0);
        prefixSum.put((long) node.val, prefixSum.getOrDefault((long) node.val, 0) + 1);

        count += dfs(node.left, target, prefixSum);
        count += dfs(node.right, target, prefixSum);

        prefixSum.put((long) node.val, prefixSum.get((long) node.val) - 1);

        return count;
    }
}