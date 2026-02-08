class Solution {
    public int sumEvenGrandparent(TreeNode root) {
        return dfs(root, null, null);
    }

    private int dfs(TreeNode node, TreeNode parent, TreeNode grandparent) {
        if (node == null) {
            return 0;
        }
        int sum = 0;
        if (grandparent != null && grandparent.val % 2 == 0) {
            sum += node.val;
        }
        sum += dfs(node.left, node, parent);
        sum += dfs(node.right, node, parent);
        return sum;
    }
}