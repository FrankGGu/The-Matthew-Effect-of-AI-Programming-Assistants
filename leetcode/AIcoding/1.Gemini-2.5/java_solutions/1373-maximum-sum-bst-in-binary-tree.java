class Solution {
    private int maxSumOverall = Integer.MIN_VALUE;
    private boolean foundBst = false;

    public int maxSumBST(TreeNode root) {
        dfs(root);
        return foundBst ? maxSumOverall : 0;
    }

    // Returns an array: {min_val, max_val, sum, is_bst_flag}
    // min_val: smallest value in the subtree (if BST, else Integer.MAX_VALUE)
    // max_val: largest value in the subtree (if BST, else Integer.MIN_VALUE)
    // sum: sum of the subtree (if BST, else 0)
    // is_bst_flag: 1 if the subtree is a BST, 0 otherwise
    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[]{Integer.MAX_VALUE, Integer.MIN_VALUE, 0, 1};
        }

        int[] leftRes = dfs(node.left);
        int[] rightRes = dfs(node.right);

        boolean isCurrentBst = (leftRes[3] == 1 && rightRes[3] == 1 &&
                                node.val > leftRes[1] && node.val < rightRes[0]);

        if (isCurrentBst) {
            int currentMin = Math.min(node.val, leftRes[0]);
            int currentMax = Math.max(node.val, rightRes[1]);
            int currentSum = leftRes[2] + rightRes[2] + node.val;

            maxSumOverall = Math.max(maxSumOverall, currentSum);
            foundBst = true;

            return new int[]{currentMin, currentMax, currentSum, 1};
        } else {
            return new int[]{Integer.MIN_VALUE, Integer.MAX_VALUE, 0, 0};
        }
    }
}