import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    Set<Integer> toDeleteSet;
    List<TreeNode> result;

    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        toDeleteSet = new HashSet<>();
        for (int val : to_delete) {
            toDeleteSet.add(val);
        }
        result = new ArrayList<>();

        dfs(root, true);

        return result;
    }

    private TreeNode dfs(TreeNode node, boolean isRoot) {
        if (node == null) {
            return null;
        }

        boolean deleted = toDeleteSet.contains(node.val);

        if (deleted) {
            dfs(node.left, true);
            dfs(node.right, true);
            return null;
        } else {
            if (isRoot) {
                result.add(node);
            }
            node.left = dfs(node.left, false);
            node.right = dfs(node.right, false);
            return node;
        }
    }
}