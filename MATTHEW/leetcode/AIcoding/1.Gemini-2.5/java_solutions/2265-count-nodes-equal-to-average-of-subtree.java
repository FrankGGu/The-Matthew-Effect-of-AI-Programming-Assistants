class Solution {
    int count = 0;

    public int averageOfSubtree(TreeNode root) {
        count = 0;
        dfs(root);
        return count;
    }

    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }

        int[] leftResult = dfs(node.left);
        int[] rightResult = dfs(node.right);

        int currentSum = node.val + leftResult[0] + rightResult[0];
        int currentCount = 1 + leftResult[1] + rightResult[1];

        if (node.val == (currentSum / currentCount)) {
            count++;
        }

        return new int[]{currentSum, currentCount};
    }
}