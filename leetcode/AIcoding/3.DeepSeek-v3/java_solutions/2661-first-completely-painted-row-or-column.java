class Solution {
    public int firstCompleteIndex(int[] arr, int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        Map<Integer, int[]> map = new HashMap<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                map.put(mat[i][j], new int[]{i, j});
            }
        }
        int[] rowCount = new int[m];
        int[] colCount = new int[n];
        for (int k = 0; k < arr.length; k++) {
            int[] pos = map.get(arr[k]);
            int i = pos[0];
            int j = pos[1];
            rowCount[i]++;
            colCount[j]++;
            if (rowCount[i] == n || colCount[j] == m) {
                return k;
            }
        }
        return -1;
    }
}