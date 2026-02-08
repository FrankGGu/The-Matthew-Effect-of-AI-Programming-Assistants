class Solution {
    public int findTree(int[][] nodes) {
        int n = nodes.length;
        boolean[] isRoot = new boolean[n];
        for (int[] node : nodes) {
            isRoot[node[1]] = true;
        }
        for (int i = 0; i < n; i++) {
            if (!isRoot[i]) {
                return i;
            }
        }
        return -1; // In case there is no root found
    }
}