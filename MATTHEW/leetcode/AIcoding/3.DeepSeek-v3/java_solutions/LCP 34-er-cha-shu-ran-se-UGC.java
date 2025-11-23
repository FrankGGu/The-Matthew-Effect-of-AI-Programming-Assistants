class Solution {
    public int maxValue(TreeNode root, int k) {
        int[] res = dfs(root, k);
        return Math.max(res[0], res[1]);
    }

    private int[] dfs(TreeNode node, int k) {
        if (node == null) {
            return new int[]{0, 0};
        }
        int[] left = dfs(node.left, k);
        int[] right = dfs(node.right, k);
        int[] res = new int[2];
        res[0] = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);
        int max = 0;
        for (int i = 0; i < k; i++) {
            int temp = left[0] + right[0] + node.val;
            if (i > 0) {
                temp = Math.max(temp, left[0] + right[1] + node.val);
                temp = Math.max(temp, left[1] + right[0] + node.val);
            }
            max = Math.max(max, temp);
        }
        res[1] = max;
        return res;
    }
}