public class Solution {
    public boolean isCompleteTree(TreeNode root) {
        if (root == null) return true;

        boolean flag = false;
        java.util.Queue<TreeNode> queue = new java.util.LinkedList<>();
        queue.add(root);

        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();

            if (node == null) {
                flag = true;
            } else {
                if (flag) return false;
                queue.add(node.left);
                queue.add(node.right);
            }
        }

        return true;
    }

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}