class Solution {
    public String tree2str(TreeNode root) {
        if (root == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.append(root.val);
        if (root.left != null || root.right != null) {
            sb.append("(");
            sb.append(tree2str(root.left));
            sb.append(")");
            if (root.right != null) {
                sb.append("(");
                sb.append(tree2str(root.right));
                sb.append(")");
            }
        }
        return sb.toString();
    }
}