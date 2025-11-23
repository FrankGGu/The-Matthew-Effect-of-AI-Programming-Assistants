class Solution {
    private int pseudoPalindromicPathCount = 0;

    public int pseudoPalindromicPaths (TreeNode root) {
        dfs(root, 0);
        return pseudoPalindromicPathCount;
    }

    private void dfs(TreeNode node, int currentPathMask) {
        if (node == null) {
            return;
        }

        currentPathMask ^= (1 << node.val);

        if (node.left == null && node.right == null) {
            if ((currentPathMask & (currentPathMask - 1)) == 0) {
                pseudoPalindromicPathCount++;
            }
        }

        dfs(node.left, currentPathMask);
        dfs(node.right, currentPathMask);
    }
}