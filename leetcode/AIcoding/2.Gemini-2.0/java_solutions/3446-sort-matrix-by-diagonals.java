class Solution {
    public int[][] diagonalSort(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        for (int i = 0; i < m; i++) {
            sortDiagonal(mat, i, 0);
        }

        for (int j = 1; j < n; j++) {
            sortDiagonal(mat, 0, j);
        }

        return mat;
    }

    private void sortDiagonal(int[][] mat, int row, int col) {
        int m = mat.length;
        int n = mat[0].length;

        List<Integer> diagonal = new ArrayList<>();
        int i = row;
        int j = col;

        while (i < m && j < n) {
            diagonal.add(mat[i][j]);
            i++;
            j++;
        }

        Collections.sort(diagonal);

        i = row;
        j = col;
        int k = 0;

        while (i < m && j < n) {
            mat[i][j] = diagonal.get(k++);
            i++;
            j++;
        }
    }
}