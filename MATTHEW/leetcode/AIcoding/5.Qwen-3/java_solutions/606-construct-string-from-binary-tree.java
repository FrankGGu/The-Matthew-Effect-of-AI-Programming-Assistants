public class Solution {
    public String tree2str(TreeNode t) {
        if (t == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        helper(t, sb);
        return sb.toString();
    }

    private void helper(TreeNode node, StringBuilder sb) {
        sb.append(node.val);
        if (node.left != null || node.right != null) {
            sb.append("(");
            helper(node.left, sb);
            sb.append(")");
            if (node.right != null) {
                sb.append("(");
                helper(node.right, sb);
                sb.append(")");
            }
        }
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}