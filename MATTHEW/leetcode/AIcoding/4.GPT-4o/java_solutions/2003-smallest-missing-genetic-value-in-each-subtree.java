class Solution {
    public int[] smallestMissingValue(TreeNode root) {
        Map<TreeNode, Set<Integer>> map = new HashMap<>();
        List<Integer> result = new ArrayList<>();
        dfs(root, map);
        for (TreeNode node : map.keySet()) {
            result.add(findSmallestMissing(map.get(node)));
        }
        return result.stream().mapToInt(i -> i).toArray();
    }

    private void dfs(TreeNode node, Map<TreeNode, Set<Integer>> map) {
        if (node == null) return;
        Set<Integer> values = new HashSet<>();
        if (node.val > 0) values.add(node.val);
        if (node.left != null) {
            dfs(node.left, map);
            values.addAll(map.get(node.left));
        }
        if (node.right != null) {
            dfs(node.right, map);
            values.addAll(map.get(node.right));
        }
        map.put(node, values);
    }

    private int findSmallestMissing(Set<Integer> values) {
        int missing = 1;
        while (values.contains(missing)) {
            missing++;
        }
        return missing;
    }
}