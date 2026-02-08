class Solution {
    public int maxLevelSum(TreeNode root) {
        if (root == null) return 0;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int maxSum = Integer.MIN_VALUE;
        int result = 0;
        int level = 1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            int currentSum = 0;

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                currentSum += node.val;

                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            if (currentSum > maxSum) {
                maxSum = currentSum;
                result = level;
            }
            level++;
        }

        return result;
    }
}