import java.util.*;

class Solution {
    public int[] treeQueries(TreeNode root, int[] queries) {
        Map<TreeNode, Integer> heightMap = new HashMap<>();
        List<TreeNode> nodes = new ArrayList<>();
        calculateHeight(root, heightMap, nodes);

        int maxHeight = 0;
        for (TreeNode node : nodes) {
            maxHeight = Math.max(maxHeight, heightMap.get(node));
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            TreeNode node = nodes.get(queries[i]);
            int heightWithoutNode = getHeightWithoutNode(node, heightMap);
            result[i] = Math.max(maxHeight, heightWithoutNode);
        }

        return result;
    }

    private int calculateHeight(TreeNode node, Map<TreeNode, Integer> heightMap, List<TreeNode> nodes) {
        if (node == null) return 0;
        int leftHeight = calculateHeight(node.left, heightMap, nodes);
        int rightHeight = calculateHeight(node.right, heightMap, nodes);
        int currentHeight = 1 + Math.max(leftHeight, rightHeight);
        heightMap.put(node, currentHeight);
        nodes.add(node);
        return currentHeight;
    }

    private int getHeightWithoutNode(TreeNode node, Map<TreeNode, Integer> heightMap) {
        if (node == null) return 0;
        int leftHeight = node.left == null ? 0 : heightMap.get(node.left);
        int rightHeight = node.right == null ? 0 : heightMap.get(node.right);
        return 1 + Math.max(leftHeight, rightHeight);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}