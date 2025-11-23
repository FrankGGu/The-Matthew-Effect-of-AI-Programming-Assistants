class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public int sumEvenGrandparent(TreeNode root) {
        return dfs(root, null, null);
    }

    private int dfs(TreeNode node, TreeNode parent, TreeNode grandparent) {
        if (node == null) return 0;
        int sum = (grandparent != null && grandparent.val % 2 == 0) ? node.val : 0;
        sum += dfs(node.left, node, parent) + dfs(node.right, node, parent);
        return sum;
    }
}