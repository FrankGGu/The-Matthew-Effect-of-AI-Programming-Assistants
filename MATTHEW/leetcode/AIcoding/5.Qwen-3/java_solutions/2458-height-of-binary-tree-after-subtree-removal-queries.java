public class Solution {

import java.util.*;

public class Solution {
    public int[] treeQueries(TreeNode root, int[] queries) {
        Map<TreeNode, Integer> depthMap = new HashMap<>();
        Map<TreeNode, Integer> heightMap = new HashMap<>();

        // First pass: calculate depth and height for each node
        dfsDepth(root, null, depthMap);
        dfsHeight(root, null, heightMap);

        // Second pass: calculate the maximum height of the tree without each subtree
        Map<TreeNode, Integer> maxHeightWithoutSubtree = new HashMap<>();
        dfsMaxHeightWithoutSubtree(root, null, 0, maxHeightWithoutSubtree);

        // Prepare result
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            TreeNode node = findNode(root, queries[i]);
            result[i] = maxHeightWithoutSubtree.getOrDefault(node, 0);
        }

        return result;
    }

    private void dfsDepth(TreeNode node, TreeNode parent, Map<TreeNode, Integer> depthMap) {
        if (node == null) return;
        depthMap.put(node, parent == null ? 0 : depthMap.get(parent) + 1);
        dfsDepth(node.left, node, depthMap);
        dfsDepth(node.right, node, depthMap);
    }

    private int dfsHeight(TreeNode node, TreeNode parent, Map<TreeNode, Integer> heightMap) {
        if (node == null) return -1;
        int leftHeight = dfsHeight(node.left, node, heightMap);
        int rightHeight = dfsHeight(node.right, node, heightMap);
        int height = Math.max(leftHeight, rightHeight) + 1;
        heightMap.put(node, height);
        return height;
    }

    private void dfsMaxHeightWithoutSubtree(TreeNode node, TreeNode parent, int currentMax, Map<TreeNode, Integer> result) {
        if (node == null) return;

        // Store the current max height excluding this subtree
        result.put(node, currentMax);

        // Compute the max height of the tree when this subtree is removed
        int leftHeight = node.left == null ? -1 : heightMap.get(node.left);
        int rightHeight = node.right == null ? -1 : heightMap.get(node.right);

        // If parent is not null, we need to consider the max height from the parent's side
        int parentMax = parent == null ? -1 : result.get(parent);

        // The new max height after removing this subtree is the max of:
        // - parent's max height (excluding this subtree)
        // - the other child's height (if exists)
        int newMax = Math.max(parentMax, Math.max(leftHeight, rightHeight));

        // Recurse on children with updated max height
        dfsMaxHeightWithoutSubtree(node.left, node, newMax, result);
        dfsMaxHeightWithoutSubtree(node.right, node, newMax, result);
    }

    private TreeNode findNode(TreeNode node, int target) {
        if (node == null) return null;
        if (node.val == target) return node;
        TreeNode left = findNode(node.left, target);
        if (left != null) return left;
        return findNode(node.right, target);
    }
}
}