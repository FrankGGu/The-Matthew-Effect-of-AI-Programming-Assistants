class Solution {
    private Map<TreeNode, Integer> depthMap = new HashMap<>();
    private Map<Integer, List<Integer>> depthToNodes = new HashMap<>();
    private Map<TreeNode, Integer> subtreeDepth = new HashMap<>();
    private int maxDepth = 0;

    public int[] treeQueries(TreeNode root, int[] queries) {
        calculateDepths(root, 0);
        precomputeSubtreeDepths(root);
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            result[i] = getMaxDepthAfterRemoval(queries[i]);
        }
        return result;
    }

    private void calculateDepths(TreeNode node, int depth) {
        if (node == null) return;
        depthMap.put(node, depth);
        depthToNodes.computeIfAbsent(depth, k -> new ArrayList<>()).add(node.val);
        maxDepth = Math.max(maxDepth, depth);
        calculateDepths(node.left, depth + 1);
        calculateDepths(node.right, depth + 1);
    }

    private int precomputeSubtreeDepths(TreeNode node) {
        if (node == null) return 0;
        int leftDepth = precomputeSubtreeDepths(node.left);
        int rightDepth = precomputeSubtreeDepths(node.right);
        int currentDepth = Math.max(leftDepth, rightDepth) + 1;
        subtreeDepth.put(node, currentDepth);
        return currentDepth;
    }

    private int getMaxDepthAfterRemoval(int query) {
        TreeNode target = findNodeByValue(root, query);
        if (target == null) return maxDepth;
        int depth = depthMap.get(target);
        List<Integer> nodesAtDepth = depthToNodes.get(depth);
        if (nodesAtDepth.size() == 1) {
            return depth - 1;
        } else {
            int maxSubtreeDepth = 0;
            for (int val : nodesAtDepth) {
                if (val != query) {
                    TreeNode node = findNodeByValue(root, val);
                    maxSubtreeDepth = Math.max(maxSubtreeDepth, subtreeDepth.get(node));
                }
            }
            return Math.max(depth - 1, depth + maxSubtreeDepth - 1);
        }
    }

    private TreeNode findNodeByValue(TreeNode node, int val) {
        if (node == null) return null;
        if (node.val == val) return node;
        TreeNode left = findNodeByValue(node.left, val);
        if (left != null) return left;
        return findNodeByValue(node.right, val);
    }

    private TreeNode root;

    public int[] treeQueries(TreeNode root, int[] queries) {
        this.root = root;
        Map<Integer, Integer> depth = new HashMap<>();
        Map<Integer, Integer> height = new HashMap<>();
        calculateDepthAndHeight(root, depth, height, 0);
        Map<Integer, TreeMap<Integer, Integer>> depthMap = new HashMap<>();
        dfs(root, depth, height, depthMap);
        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int q = queries[i];
            int d = depth.get(q);
            TreeMap<Integer, Integer> tm = depthMap.get(d);
            if (tm.size() == 1) {
                res[i] = d - 1;
            } else {
                if (tm.lastKey() == height.get(q)) {
                    res[i] = d + tm.lowerKey(tm.lastKey()) - 1;
                } else {
                    res[i] = d + tm.lastKey() - 1;
                }
            }
        }
        return res;
    }

    private void calculateDepthAndHeight(TreeNode node, Map<Integer, Integer> depth, Map<Integer, Integer> height, int currentDepth) {
        if (node == null) return;
        depth.put(node.val, currentDepth);
        int leftHeight = 0, rightHeight = 0;
        calculateDepthAndHeight(node.left, depth, height, currentDepth + 1);
        calculateDepthAndHeight(node.right, depth, height, currentDepth + 1);
        if (node.left != null) leftHeight = height.get(node.left.val);
        if (node.right != null) rightHeight = height.get(node.right.val);
        height.put(node.val, Math.max(leftHeight, rightHeight) + 1);
    }

    private void dfs(TreeNode node, Map<Integer, Integer> depth, Map<Integer, Integer> height, Map<Integer, TreeMap<Integer, Integer>> depthMap) {
        if (node == null) return;
        int d = depth.get(node.val);
        int h = height.get(node.val);
        depthMap.computeIfAbsent(d, k -> new TreeMap<>()).merge(h, 1, Integer::sum);
        dfs(node.left, depth, height, depthMap);
        dfs(node.right, depth, height, depthMap);
    }
}