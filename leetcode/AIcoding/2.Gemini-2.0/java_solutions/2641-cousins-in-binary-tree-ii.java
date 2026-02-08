class Solution {
    public TreeNode replaceValueInTree(TreeNode root) {
        if (root == null) {
            return null;
        }

        root.val = 0;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            int size = queue.size();
            int sum = 0;
            List<TreeNode> levelNodes = new ArrayList<>();

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                if (node.left != null) {
                    sum += node.left.val;
                    levelNodes.add(node.left);
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    sum += node.right.val;
                    levelNodes.add(node.right);
                    queue.offer(node.right);
                }
            }

            for (TreeNode node : levelNodes) {
                int siblingSum = 0;
                TreeNode parent = findParent(root, node);

                if (parent.left != null && parent.left != node) {
                    siblingSum += parent.left.val;
                }
                if (parent.right != null && parent.right != node) {
                    siblingSum += parent.right.val;
                }

                node.val = sum - siblingSum;
            }
        }

        return root;
    }

    private TreeNode findParent(TreeNode root, TreeNode node) {
        if (root == null || root == node) {
            return null;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            TreeNode current = queue.poll();

            if (current.left == node || current.right == node) {
                return current;
            }

            if (current.left != null) {
                queue.offer(current.left);
            }
            if (current.right != null) {
                queue.offer(current.right);
            }
        }

        return null;
    }
}