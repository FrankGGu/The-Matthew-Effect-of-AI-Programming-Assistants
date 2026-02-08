class Solution {
    public int[][] diagonalSort(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        for (int k = 0; k < m; k++) {
            List<Integer> diagonal = new ArrayList<>();
            int i = k, j = 0;
            while (i < m && j < n) {
                diagonal.add(mat[i][j]);
                i++;
                j++;
            }
            Collections.sort(diagonal);

            i = k;
            j = 0;
            int index = 0;
            while (i < m && j < n) {
                mat[i][j] = diagonal.get(index++);
                i++;
                j++;
            }
        }

        for (int k = 1; k < n; k++) {
            List<Integer> diagonal = new ArrayList<>();
            int i = 0, j = k;
            while (i < m && j < n) {
                diagonal.add(mat[i][j]);
                i++;
                j++;
            }
            Collections.sort(diagonal);

            i = 0;
            j = k;
            int index = 0;
            while (i < m && j < n) {
                mat[i][j] = diagonal.get(index++);
                i++;
                j++;
            }
        }

        return mat;
    }
}