public class Solution {
    int sum = 0;

    public int sumEvenGrandparent(TreeNode root) {
        dfs(root, null, null);
        return sum;
    }

    private void dfs(TreeNode node, TreeNode parent, TreeNode grandParent) {
        if (node == null) {
            return;
        }
        if (grandParent != null && grandParent.val % 2 == 0) {
            sum += node.val;
        }
        dfs(node.left, node, parent);
        dfs(node.right, node, parent);
    }
}