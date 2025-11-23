class Solution {
    int count = 0;

    public int averageOfSubtree(TreeNode root) {
        count = 0;
        traverse(root);
        return count;
    }

    private int[] traverse(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }

        int[] left = traverse(node.left);
        int[] right = traverse(node.right);

        int sum = node.val + left[0] + right[0];
        int numNodes = 1 + left[1] + right[1];

        if (sum / numNodes == node.val) {
            count++;
        }

        return new int[]{sum, numNodes};
    }
}