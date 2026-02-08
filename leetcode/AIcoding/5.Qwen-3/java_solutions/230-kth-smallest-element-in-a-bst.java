public class Solution {
    public int kthSmallest(TreeNode root, int k) {
        int[] result = new int[1];
        int[] count = new int[1];
        inorderTraversal(root, k, result, count);
        return result[0];
    }

    private void inorderTraversal(TreeNode node, int k, int[] result, int[] count) {
        if (node == null || result[0] != 0) {
            return;
        }
        inorderTraversal(node.left, k, result, count);
        count[0]++;
        if (count[0] == k) {
            result[0] = node.val;
            return;
        }
        inorderTraversal(node.right, k, result, count);
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}