public class Solution {
    public int[] getTargetCopy(TreeNode original, TreeNode cloned, TreeNode target) {
        int[] result = new int[2];
        dfs(original, cloned, target, result);
        return result;
    }

    private void dfs(TreeNode original, TreeNode cloned, TreeNode target, int[] result) {
        if (original == null) {
            return;
        }
        if (original == target) {
            result[0] = cloned.val;
            result[1] = cloned.val;
            return;
        }
        dfs(original.left, cloned.left, target, result);
        dfs(original.right, cloned.right, target, result);
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}