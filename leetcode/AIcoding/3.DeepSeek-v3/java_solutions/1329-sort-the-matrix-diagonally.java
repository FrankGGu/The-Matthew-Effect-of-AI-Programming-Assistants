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

    private void sortDiagonal(int[][] mat, int i, int j) {
        List<Integer> diagonal = new ArrayList<>();
        int x = i, y = j;
        while (x < mat.length && y < mat[0].length) {
            diagonal.add(mat[x][y]);
            x++;
            y++;
        }

        Collections.sort(diagonal);

        x = i;
        y = j;
        int idx = 0;
        while (x < mat.length && y < mat[0].length) {
            mat[x][y] = diagonal.get(idx++);
            x++;
            y++;
        }
    }
}