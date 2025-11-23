public class Solution {
    public int sumRootToLeaf(int[] root) {
        return dfs(root, 0);
    }

    private int dfs(int[] root, int current) {
        if (root == null) return 0;
        current = (current << 1) | root[0];
        if (root[1] == -1 && root[2] == -1) return current;
        int left = root[1] != -1 ? dfs(getSubtree(root, root[1]), current) : 0;
        int right = root[2] != -1 ? dfs(getSubtree(root, root[2]), current) : 0;
        return left + right;
    }

    private int[] getSubtree(int[] root, int index) {
        int size = root.length;
        int[] subtree = new int[size];
        for (int i = 0; i < size; i++) {
            subtree[i] = root[i];
        }
        return subtree;
    }
}