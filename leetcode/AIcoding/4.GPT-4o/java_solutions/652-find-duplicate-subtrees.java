import java.util.*;

class Solution {
    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        Map<String, Integer> map = new HashMap<>();
        List<TreeNode> result = new ArrayList<>();
        serialize(root, map, result);
        return result;
    }

    private String serialize(TreeNode node, Map<String, Integer> map, List<TreeNode> result) {
        if (node == null) return "#";
        String serial = node.val + "," + serialize(node.left, map, result) + "," + serialize(node.right, map, result);
        map.put(serial, map.getOrDefault(serial, 0) + 1);
        if (map.get(serial) == 2) {
            result.add(node);
        }
        return serial;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}