import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<TreeNode, Integer> memo = new HashMap<>();

    public int minimumTime(TreeNode root) {
        return dfs(root);
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }
        if (memo.containsKey(node)) {
            return memo.get(node);
        }

        int left = dfs(node.left);
        int right = dfs(node.right);

        int result = node.val + Math.max(left, right);
        memo.put(node, result);
        return result;
    }
}