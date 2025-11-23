class Solution {
    public int findSecondMinimumValue(TreeNode root) {
        if (root == null) return -1;

        Integer secondMin = null;
        int min = root.val;

        java.util.Queue<TreeNode> queue = new java.util.LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();

            if (node.val > min) {
                if (secondMin == null || node.val < secondMin) {
                    secondMin = node.val;
                }
            }

            if (node.left != null) {
                queue.offer(node.left);
            }
            if (node.right != null) {
                queue.offer(node.right);
            }
        }

        return secondMin == null ? -1 : secondMin;
    }
}