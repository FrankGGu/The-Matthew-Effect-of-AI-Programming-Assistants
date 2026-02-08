class Solution {
    int totalSum = 0;

    public int sumEvenGrandparent(TreeNode root) {
        dfs(root, -1, -1);
        return totalSum;
    }

    private void dfs(TreeNode node, int parentVal, int grandparentVal) {
        if (node == null) {
            return;
        }

        if (grandparentVal != -1 && grandparentVal % 2 == 0) {
            totalSum += node.val;
        }

        dfs(node.left, node.val, parentVal);
        dfs(node.right, node.val, parentVal);
    }
}