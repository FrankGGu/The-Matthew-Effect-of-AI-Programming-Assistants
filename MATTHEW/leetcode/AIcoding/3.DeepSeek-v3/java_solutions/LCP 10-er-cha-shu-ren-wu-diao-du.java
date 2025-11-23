class Solution {
    public int minimalExecTime(TreeNode root) {
        int[] res = dfs(root);
        return res[0] + res[1];
    }

    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }
        int[] left = dfs(node.left);
        int[] right = dfs(node.right);
        int sum = left[0] + right[0];
        int maxParallel = Math.max(left[1], right[1]);
        if (left[0] > right[0]) {
            int diff = left[0] - right[0];
            if (diff > 2 * maxParallel) {
                maxParallel = left[1] + diff - maxParallel;
            } else {
                maxParallel = (sum + 1) / 2;
            }
        } else if (right[0] > left[0]) {
            int diff = right[0] - left[0];
            if (diff > 2 * maxParallel) {
                maxParallel = right[1] + diff - maxParallel;
            } else {
                maxParallel = (sum + 1) / 2;
            }
        } else {
            maxParallel = sum / 2;
        }
        return new int[]{sum + node.val, maxParallel};
    }
}