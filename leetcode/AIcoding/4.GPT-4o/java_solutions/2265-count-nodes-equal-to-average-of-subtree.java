class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    private int count = 0;

    public int averageOfSubtree(TreeNode root) {
        countNodes(root);
        return count;
    }

    private int[] countNodes(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0}; // sum, count
        }
        int[] left = countNodes(node.left);
        int[] right = countNodes(node.right);

        int sum = left[0] + right[0] + node.val;
        int totalCount = left[1] + right[1] + 1;

        if (sum / totalCount == node.val) {
            count++;
        }

        return new int[]{sum, totalCount};
    }
}