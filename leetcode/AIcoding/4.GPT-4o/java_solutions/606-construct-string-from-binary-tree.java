class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public String tree2str(TreeNode root) {
        if (root == null) return "";
        StringBuilder sb = new StringBuilder();
        sb.append(root.val);
        if (root.left != null || root.right != null) {
            sb.append("(").append(tree2str(root.left)).append(")");
            if (root.right != null) {
                sb.append("(").append(tree2str(root.right)).append(")");
            }
        }
        return sb.toString();
    }
}