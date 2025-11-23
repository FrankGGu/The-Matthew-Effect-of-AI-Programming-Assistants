class Solution {
    public boolean isCousins(TreeNode root, int x, int y) {
        int xDepth = -1, yDepth = -1;
        TreeNode xParent = null, yParent = null;

        java.util.Queue<TreeNode> q = new java.util.LinkedList<>();
        q.offer(root);
        int depth = 0;

        while (!q.isEmpty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                TreeNode node = q.poll();

                if (node.left != null) {
                    if (node.left.val == x) {
                        xDepth = depth + 1;
                        xParent = node;
                    } else if (node.left.val == y) {
                        yDepth = depth + 1;
                        yParent = node;
                    }
                    q.offer(node.left);
                }

                if (node.right != null) {
                    if (node.right.val == x) {
                        xDepth = depth + 1;
                        xParent = node;
                    } else if (node.right.val == y) {
                        yDepth = depth + 1;
                        yParent = node;
                    }
                    q.offer(node.right);
                }
            }
            depth++;
        }

        return xDepth == yDepth && xParent != yParent;
    }
}