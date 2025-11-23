class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    private Integer secondMin = null;

    public int findSecondMinimumValue(TreeNode root) {
        if (root == null) return -1;
        dfs(root, root.val);
        return secondMin == null ? -1 : secondMin;
    }

    private void dfs(TreeNode node, int firstMin) {
        if (node == null) return;
        if (node.val > firstMin) {
            if (secondMin == null || node.val < secondMin) {
                secondMin = node.val;
            }
        }
        dfs(node.left, firstMin);
        dfs(node.right, firstMin);
    }
}