class Solution {
    public int[][] construct2DArray(int[] parent, int width) {
        int n = parent.length;
        int[][] result = new int[n][2];
        for (int i = 0; i < n; i++) {
            if (parent[i] == -1) {
                result[i][0] = -1;
                result[i][1] = -1;
            } else {
                result[i][0] = parent[i] / width;
                result[i][1] = parent[i] % width;
            }
        }
        return result;
    }
}