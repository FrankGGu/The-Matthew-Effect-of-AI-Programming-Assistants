import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

class Solution {
    private Map<Integer, TreeNode> rootMap; // Stores original trees keyed by their root value
    private Map<Integer, Integer> valueCounts; // Counts occurrences of each value across all nodes
    private Set<Integer> childValues; // Stores values that appear as children of some node

    private long prevVal; // For in-order BST validation
    private int mergedNodesCount; // To count nodes in the final merged tree

    public TreeNode canMerge(List<TreeNode> trees) {
        rootMap = new HashMap<>();
        valueCounts = new HashMap<>();
        childValues = new HashSet<>();

        // Step 1: Populate maps/sets
        for (TreeNode tree : trees) {
            if (rootMap.containsKey(tree.val)) {
                return null; // Duplicate root value in input list, impossible to merge
            }
            rootMap.put(tree.val, tree);
            collectValuesAndChildren(tree);
        }

        // Post-collection check for true duplicates (values appearing >1 times and not being a root)
        for (Integer val : valueCounts.keySet()) {
            if (valueCounts.get(val) > 1 && !rootMap.containsKey(val)) {
                return null; // A value appears more than once, and it's not a root of some tree
                            // (which would be a merge point). This is a true duplicate.
            }
        }

        // Step 2: Find the potential final root
        TreeNode finalRoot = null;
        for (Integer rootVal : rootMap.keySet()) {
            if (!childValues.contains(rootVal)) { // This root value is not a child of any other tree
                if (finalRoot != null) {
                    return null; // More than one candidate for the final root
                }
                finalRoot = rootMap.get(rootVal);
            }
        }

        if (finalRoot == null) {
            return null; // No single root found (e.g., all roots are children, implies a cycle or disjoint trees)
        }

        // Remove the chosen final root from rootMap so it only contains subtrees to be merged.
        rootMap.remove(finalRoot.val); 

        // Step 3: Perform DFS to merge and validate BST property
        prevVal = Long.MIN_VALUE; // Initialize for in-order traversal validation
        mergedNodesCount = 0;

        if (!dfsMergeAndValidate(finalRoot)) {
            return null; // BST property violated or cycle detected during merge
        }

        // Step 4: Final checks
        if (!rootMap.isEmpty()) {
            return null; // Some trees were not merged
        }

        // Check if all unique values from input trees are present in the final merged tree
        if (mergedNodesCount != valueCounts.size()) {
             return null; // Not all unique values from input trees are in the final tree.
        }

        return finalRoot;
    }

    // Helper to collect all node values and identify child values
    private void collectValuesAndChildren(TreeNode node) {
        if (node == null) {
            return;
        }

        valueCounts.put(node.val, valueCounts.getOrDefault(node.val, 0) + 1);

        if (node.left != null) {
            childValues.add(node.left.val);
            collectValuesAndChildren(node.left);
        }
        if (node.right != null) {
            childValues.add(node.right.val);
            collectValuesAndChildren(node.right);
        }
    }

    // Helper to perform DFS, merge subtrees, and validate BST property
    private boolean dfsMergeAndValidate(TreeNode node) {
        if (node == null) {
            return true;
        }

        // Merge step: Check if children can be replaced by roots of other trees.
        // This must happen before traversing children, as children might change.
        if (node.left != null && rootMap.containsKey(node.left.val)) {
            TreeNode subTree = rootMap.get(node.left.val);
            node.left = subTree; // Replace the child node with the root of the subtree
            rootMap.remove(subTree.val); // Mark this subtree as used.
        }
        if (node.right != null && rootMap.containsKey(node.right.val)) {
            TreeNode subTree = rootMap.get(node.right.val);
            node.right = subTree; // Replace the child node with the root of the subtree
            rootMap.remove(subTree.val); // Mark this subtree as used.
        }

        // Validate left subtree
        if (!dfsMergeAndValidate(node.left)) {
            return false;
        }

        // Validate current node (in-order check)
        if (node.val <= prevVal) {
            return false; // BST property violation
        }
        prevVal = node.val;
        mergedNodesCount++; // Count this node as successfully merged and validated

        // Validate right subtree
        if (!dfsMergeAndValidate(node.right)) {
            return false;
        }

        return true;
    }
}