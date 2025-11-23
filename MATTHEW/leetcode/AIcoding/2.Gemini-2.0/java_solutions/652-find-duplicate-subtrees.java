import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        List<TreeNode> res = new ArrayList<>();
        Map<String, Integer> count = new HashMap<>();
        dfs(root, count, res);
        return res;
    }

    private String dfs(TreeNode node, Map<String, Integer> count, List<TreeNode> res) {
        if (node == null) {
            return "#";
        }
        String str = node.val + "," + dfs(node.left, count, res) + "," + dfs(node.right, count, res);
        count.put(str, count.getOrDefault(str, 0) + 1);
        if (count.get(str) == 2) {
            res.add(node);
        }
        return str;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {
        }

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}