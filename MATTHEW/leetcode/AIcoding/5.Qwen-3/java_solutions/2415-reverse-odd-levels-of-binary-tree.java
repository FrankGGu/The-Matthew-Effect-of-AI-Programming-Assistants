public class Solution {

class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        if (root == null) return null;

        java.util.Queue<TreeNode> queue = new java.util.LinkedList<>();
        queue.add(root);

        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            java.util.List<TreeNode> levelNodes = new java.util.ArrayList<>();

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                levelNodes.add(node);

                if (node.left != null) queue.add(node.left);
                if (node.right != null) queue.add(node.right);
            }

            if (level % 2 == 1) {
                int left = 0;
                int right = levelNodes.size() - 1;

                while (left < right) {
                    int tempVal = levelNodes.get(left).val;
                    levelNodes.get(left).val = levelNodes.get(right).val;
                    levelNodes.get(right).val = tempVal;
                    left++;
                    right--;
                }
            }

            level++;
        }

        return root;
    }

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}