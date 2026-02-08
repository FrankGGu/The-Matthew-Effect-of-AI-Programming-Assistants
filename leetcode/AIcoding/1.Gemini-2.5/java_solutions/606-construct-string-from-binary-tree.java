class Solution {
    public String tree2str(TreeNode root) {
        if (root == null) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        sb.append(root.val);

        String leftStr = tree2str(root.left);
        String rightStr = tree2str(root.right);

        if (root.left == null && root.right == null) {
            return sb.toString();
        }

        if (root.left == null) { // Has right child but no left child
            sb.append("()");
        } else { // Has left child
            sb.append("(").append(leftStr).append(")");
        }

        if (root.right != null) { // Has right child (whether or not it has a left child)
            sb.append("(").append(rightStr).append(")");
        }

        return sb.toString();
    }
}