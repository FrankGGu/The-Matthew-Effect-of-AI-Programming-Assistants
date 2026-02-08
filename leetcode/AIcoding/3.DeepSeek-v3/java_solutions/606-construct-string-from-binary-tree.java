class Solution {
    public String tree2str(TreeNode root) {
        if (root == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        helper(root, sb);
        return sb.toString();
    }

    private void helper(TreeNode node, StringBuilder sb) {
        sb.append(node.val);
        if (node.left == null && node.right == null) {
            return;
        }
        if (node.left != null) {
            sb.append("(");
            helper(node.left, sb);
            sb.append(")");
        } else {
            sb.append("()");
        }
        if (node.right != null) {
            sb.append("(");
            helper(node.right, sb);
            sb.append(")");
        }
    }
}