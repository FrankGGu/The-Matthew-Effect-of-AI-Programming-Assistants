class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    private int count = 0;

    public int countPairs(TreeNode root, int distance) {
        dfs(root, distance);
        return count;
    }

    private int[] dfs(TreeNode node, int distance) {
        if (node == null) return new int[distance];
        int[] left = dfs(node.left, distance);
        int[] right = dfs(node.right, distance);
        for (int i = 0; i < distance - 1; i++) {
            count += left[i] * right[distance - 2 - i];
        }
        int[] res = new int[distance];
        for (int i = 0; i < distance - 1; i++) {
            res[i + 1] += left[i];
            res[i + 1] += right[i];
        }
        res[0] = 1;
        return res;
    }
}