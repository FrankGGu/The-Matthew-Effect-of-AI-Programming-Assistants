class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public boolean leafSimilar(TreeNode root1, TreeNode root2) {
        StringBuilder leaves1 = new StringBuilder();
        StringBuilder leaves2 = new StringBuilder();
        getLeaves(root1, leaves1);
        getLeaves(root2, leaves2);
        return leaves1.toString().equals(leaves2.toString());
    }

    private void getLeaves(TreeNode node, StringBuilder leaves) {
        if (node == null) return;
        if (node.left == null && node.right == null) {
            leaves.append(node.val).append(",");
        }
        getLeaves(node.left, leaves);
        getLeaves(node.right, leaves);
    }
}