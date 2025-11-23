class Solution {
    public TreeNode replaceValueInTree(TreeNode root) {
        if (root == null) return null;
        Map<Integer, Integer> levelSum = new HashMap<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int level = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            int sum = 0;
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                sum += node.val;
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            levelSum.put(level, sum);
            level++;
        }
        queue.offer(root);
        root.val = 0;
        level = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                int childrenSum = 0;
                if (node.left != null) childrenSum += node.left.val;
                if (node.right != null) childrenSum += node.right.val;
                if (node.left != null) {
                    int leftVal = levelSum.get(level + 1) - childrenSum;
                    node.left.val = leftVal;
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    int rightVal = levelSum.get(level + 1) - childrenSum;
                    node.right.val = rightVal;
                    queue.offer(node.right);
                }
            }
            level++;
        }
        return root;
    }
}