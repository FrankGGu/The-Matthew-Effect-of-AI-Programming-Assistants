import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private long totalInversionSum = 0;
    private Map<Integer, Integer> valToCoord;
    private int maxCoord; // Size for Fenwick Tree

    public long subtreeInversionSum(TreeNode root) {
        if (root == null) {
            return 0;
        }

        List<Integer> allVals = new ArrayList<>();
        collectValues(root, allVals);
        Collections.sort(allVals);

        valToCoord = new HashMap<>();
        int coordCounter = 0;
        for (int val : allVals) {
            if (!valToCoord.containsKey(val)) {
                valToCoord.put(val, coordCounter++);
            }
        }
        maxCoord = coordCounter; // maxCoord is the number of unique values, used as size for Fenwick Tree

        dfs(root);
        return totalInversionSum;
    }

    private void collectValues(TreeNode node, List<Integer> allVals) {
        if (node == null) {
            return;
        }
        allVals.add(node.val);
        collectValues(node.left, allVals);
        collectValues(node.right, allVals);
    }

    // Fenwick Tree (BIT) implementation
    static class FenwickTree {
        int[] bit;
        int size;

        FenwickTree(int size) {
            this.size = size;
            this.bit = new int[size + 1]; // 1-indexed
        }

        // Updates the count at a given 0-indexed coordinate
        void update(int idx, int delta) {
            idx++; // Convert to 1-indexed for BIT
            while (idx <= size) {
                bit[idx] += delta;
                idx += idx & (-idx);
            }
        }

        // Queries the prefix sum up to a given 0-indexed coordinate (inclusive)
        int query(int idx) {
            idx++; // Convert to 1-indexed
            int sum = 0;
            while (idx > 0) {
                sum += bit[idx];
                idx -= idx & (-idx);
            }
            return sum;
        }

        // Queries the sum of elements with coordinate strictly greater than targetCoord
        int queryGreaterThan(int targetCoord) {
            // Sum from targetCoord + 1 to size - 1
            return query(size - 1) - query(targetCoord);
        }
    }

    // Custom class to hold results from DFS
    static class DSUResult {
        long inversions; // Total inversions within this subtree
        FenwickTree ft;   // Fenwick tree representing values in this subtree
        List<Integer> values; // Original values in this subtree (needed for DSU on tree iteration)
        int numNodes;     // Number of nodes in this subtree

        DSUResult(long inversions, FenwickTree ft, List<Integer> values, int numNodes) {
            this.inversions = inversions;
            this.ft = ft;
            this.values = values;
            this.numNodes = numNodes;
        }
    }

    private DSUResult dfs(TreeNode node) {
        if (node == null) {
            return new DSUResult(0, new FenwickTree(maxCoord), new ArrayList<>(), 0);
        }

        DSUResult leftRes = dfs(node.left);
        DSUResult rightRes = dfs(node.right);

        long currentSubtreeInversions = leftRes.inversions + rightRes.inversions;

        DSUResult smallerRes;
        DSUResult largerRes;

        // DSU on tree (small to large merging):
        // We iterate through the elements of the smaller subtree and add them to the Fenwick Tree of the larger subtree.
        if (leftRes.numNodes < rightRes.numNodes) {
            smallerRes = leftRes;
            largerRes = rightRes;
        } else {
            smallerRes = rightRes;
            largerRes = leftRes;
        }

        // Process elements from the smaller subtree:
        // For each value in the smaller subtree, count inversions with elements already in the larger subtree's FT,
        // then add the value to the larger subtree's FT.
        for (int val : smallerRes.values) {
            int coord = valToCoord.get(val);
            // Count elements in the larger subtree that are greater than 'val'
            currentSubtreeInversions += largerRes.ft.queryGreaterThan(coord);
            largerRes.ft.update(coord, 1); // Add 'val' to the larger subtree's FT
        }

        // Process the current node's value:
        // Count inversions with elements already in the combined FT (from children),
        // then add the current node's value to the FT.
        int nodeCoord = valToCoord.get(node.val);
        currentSubtreeInversions += largerRes.ft.queryGreaterThan(nodeCoord);
        largerRes.ft.update(nodeCoord, 1); // Add current node's value to the FT

        // Update the list of values for the current subtree
        largerRes.values.addAll(smallerRes.values);
        largerRes.values.add(node.val);

        // Update the number of nodes for the current subtree
        largerRes.numNodes = leftRes.numNodes + rightRes.numNodes + 1;

        // The 'inversions' field of largerRes now holds the total inversions for the current node's subtree.
        largerRes.inversions = currentSubtreeInversions;
        totalInversionSum += currentSubtreeInversions; // Accumulate to the global total

        return largerRes;
    }
}