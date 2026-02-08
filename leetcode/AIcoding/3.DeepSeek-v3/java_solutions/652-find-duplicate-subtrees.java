class Solution {
    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        List<TreeNode> res = new ArrayList<>();
        Map<String, Integer> map = new HashMap<>();
        serialize(root, map, res);
        return res;
    }

    private String serialize(TreeNode node, Map<String, Integer> map, List<TreeNode> res) {
        if (node == null) return "#";
        String key = node.val + "," + serialize(node.left, map, res) + "," + serialize(node.right, map, res);
        map.put(key, map.getOrDefault(key, 0) + 1);
        if (map.get(key) == 2) res.add(node);
        return key;
    }
}