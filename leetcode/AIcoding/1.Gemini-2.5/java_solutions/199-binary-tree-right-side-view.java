import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        dfs(root, result, 0);
        return result;
    }

    private void dfs(TreeNode node, List<Integer> result, int depth) {
        if (node == null) {
            return;
        }

        if (depth == result.size()) {
            result.add(node.val);
        }

        dfs(node.right, result, depth + 1);
        dfs(node.left, result, depth + 1);
    }
}