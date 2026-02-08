class Solution {
    public int maximizeTargetNodes(TreeNode root1, TreeNode root2) {
        int[] count1 = new int[1];
        int[] count2 = new int[1];
        countNodes(root1, count1);
        countNodes(root2, count2);
        return Math.min(count1[0], count2[0]);
    }

    private void countNodes(TreeNode node, int[] count) {
        if (node == null) return;
        count[0]++;
        countNodes(node.left, count);
        countNodes(node.right, count);
    }
}