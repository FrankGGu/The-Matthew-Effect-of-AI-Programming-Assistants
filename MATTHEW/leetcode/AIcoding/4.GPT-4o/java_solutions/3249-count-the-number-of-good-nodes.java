class Solution {
    public int goodNodes(TreeNode root) {
        return countGoodNodes(root, root.val);
    }

    private int countGoodNodes(TreeNode node, int max) {
        if (node == null) return 0;
        int good = node.val >= max ? 1 : 0;
        max = Math.max(max, node.val);
        good += countGoodNodes(node.left, max);
        good += countGoodNodes(node.right, max);
        return good;
    }
}