import java.util.*;

class Solution {
    private static final int MAX_BITS = 18; // nums[i] and val up to 2 * 10^5, 2^18 = 262144
    private static final int MAX_DEPTH_PLUS_VAL = 300005; // Max possible depth + val (N-1 + 2*10^5)

    static class TrieNode {
        TrieNode[] children;
        // Fenwick tree to store counts of numbers at specific depths
        // Using a TreeMap to simulate a sparse Fenwick tree for depths
        // Key: depth, Value: count
        TreeMap<Integer, Integer> depthCounts;

        TrieNode() {
            children = new TrieNode[2];
            depthCounts = new TreeMap<>();
        }
    }

    private TrieNode root;
    private List<Integer>[] adj;
    private int[] nums;
    private int[] depths;
    private List<Query>[] queriesAtNode;
    private int[] ans;

    static class Query {
        int val; // The value to XOR with
        int depthLimitDiff; // The 'val' from problem statement for depth constraint
        int originalIdx;

        Query(int val, int depthLimitDiff, int originalIdx) {
            this.val = val;
            this.depthLimitDiff = depthLimitDiff;
            this.originalIdx = originalIdx;
        }
    }

    public int[] maxGeneticDifference(int[] parents, int[] nums, int[][] queries) {
        int n = parents.length;
        this.nums = nums;

        adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        int rootNode = -1;
        for (int i = 0; i < n; i++) {
            if (parents[i] == -1) {
                rootNode = i;
            } else {
                adj[parents[i]].add(i);
            }
        }

        depths = new int[n];
        calculateDepths(rootNode, -1, 0);

        queriesAtNode = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            queriesAtNode[i] = new ArrayList<>();
        }

        for (int i = 0; i < queries.length; i++) {
            int node = queries[i][0];
            int val = queries[i][1];
            queriesAtNode[node].add(new Query(val, val, i));
        }

        ans = new int[queries.length];
        root = new TrieNode();

        dfsSolve(rootNode, -1);

        return ans;
    }

    private void calculateDepths(int u, int p, int d) {
        depths[u] = d;
        for (int v : adj[u]) {
            if (v != p) {
                calculateDepths(v, u, d + 1);
            }
        }
    }

    private void dfsSolve(int u, int p) {
        add(nums[u], depths[u], 1);

        for (Query q : queriesAtNode[u]) {
            int targetDepth = depths[u] + q.depthLimitDiff;
            ans[q.originalIdx] = query(q.val, targetDepth);
        }

        for (int v : adj[u]) {
            if (v != p) {
                dfsSolve(v, u);
            }
        }

        add(nums[u], depths[u], -1);
    }

    private void add(int val, int depth, int delta) {
        TrieNode curr = root;
        updateFenwickTree(curr.depthCounts, depth, delta);

        for (int i = MAX_BITS - 1; i >= 0; i--) {
            int bit = (val >> i) & 1;
            if (curr.children[bit] == null) {
                curr.children[bit] = new TrieNode();
            }
            curr = curr.children[bit];
            updateFenwickTree(curr.depthCounts, depth, delta);
        }
    }

    private int query(int val, int targetDepth) {
        TrieNode curr = root;
        int max_xor = 0;

        for (int i = MAX_BITS - 1; i >= 0; i--) {
            int bit = (val >> i) & 1;
            int targetBit = 1 - bit;

            if (curr.children[targetBit] != null && queryFenwickTree(curr.children[targetBit].depthCounts, targetDepth) > 0) {
                max_xor |= (1 << i);
                curr = curr.children[targetBit];
            } else if (curr.children[bit] != null && queryFenwickTree(curr.children[bit].depthCounts, targetDepth) > 0) {
                curr = curr.children[bit];
            } else {
                return max_xor;
            }
        }
        return max_xor;
    }

    private void updateFenwickTree(TreeMap<Integer, Integer> map, int depth, int delta) {
        depth++; // Fenwick tree is 1-indexed
        while (depth < MAX_DEPTH_PLUS_VAL) {
            map.put(depth, map.getOrDefault(depth, 0) + delta);
            depth += (depth & -depth);
        }
    }

    private int queryFenwickTree(TreeMap<Integer, Integer> map, int targetDepth) {
        targetDepth++; // Fenwick tree is 1-indexed
        int sum = 0;
        while (targetDepth > 0) {
            sum += map.getOrDefault(targetDepth, 0);
            targetDepth -= (targetDepth & -targetDepth);
        }
        return sum;
    }
}