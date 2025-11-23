public class Solution {

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        List<TreeNode> result = new ArrayList<>();
        Map<String, Integer> map = new HashMap<>();
        serialize(root, map, result);
        return result;
    }

    private String serialize(TreeNode node, Map<String, Integer> map, List<TreeNode> result) {
        if (node == null) {
            return "#";
        }
        String key = node.val + "," + serialize(node.left, map, result) + "," + serialize(node.right, map, result);
        map.put(key, map.getOrDefault(key, 0) + 1);
        if (map.get(key) == 2) {
            result.add(node);
        }
        return key;
    }

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

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
}