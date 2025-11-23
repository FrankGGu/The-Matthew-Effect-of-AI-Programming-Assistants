public class Solution {


class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public int maxValue(TreeNode root, int k) {
        return dfs(root, k)[0];
    }

    private int[] dfs(TreeNode node, int k) {
        if (node == null) {
            return new int[]{0, 0};
        }

        int[] left = dfs(node.left, k);
        int[] right = dfs(node.right, k);

        int selected = node.val + left[1] + right[1];
        int notSelected = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return new int[]{selected, notSelected};
    }
}
}