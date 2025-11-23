class Solution {
    private int count;

    public int countPairs(TreeNode root, int distance) {
        count = 0;
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

        int[] current = new int[distance];
        for (int i = 0; i < distance - 1; i++) {
            current[i + 1] = left[i] + right[i];
        }
        current[0] = 1;

        return current;
    }
}