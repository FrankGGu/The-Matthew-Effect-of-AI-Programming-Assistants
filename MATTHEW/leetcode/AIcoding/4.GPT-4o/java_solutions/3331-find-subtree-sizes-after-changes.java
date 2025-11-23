class Solution {
    public List<Integer> findSubtreeSizes(TreeNode root, int[][] queries) {
        Map<TreeNode, Integer> sizeMap = new HashMap<>();
        List<Integer> result = new ArrayList<>();

        calculateSubtreeSizes(root, sizeMap);

        for (int[] query : queries) {
            TreeNode node = findNode(root, query[0]);
            result.add(sizeMap.getOrDefault(node, 0));
        }

        return result;
    }

    private int calculateSubtreeSizes(TreeNode node, Map<TreeNode, Integer> sizeMap) {
        if (node == null) return 0;
        int size = 1 + calculateSubtreeSizes(node.left, sizeMap) + calculateSubtreeSizes(node.right, sizeMap);
        sizeMap.put(node, size);
        return size;
    }

    private TreeNode findNode(TreeNode root, int val) {
        if (root == null || root.val == val) return root;
        TreeNode left = findNode(root.left, val);
        if (left != null) return left;
        return findNode(root.right, val);
    }
}