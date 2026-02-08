import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int[][] diagonalSort(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        for (int j = 0; j < n; j++) {
            sortDiagonal(mat, 0, j, m, n);
        }

        for (int i = 1; i < m; i++) {
            sortDiagonal(mat, i, 0, m, n);
        }

        return mat;
    }

    private void sortDiagonal(int[][] mat, int r, int c, int m, int n) {
        List<Integer> diagonalElements = new ArrayList<>();
        int curr_r = r;
        int curr_c = c;

        while (curr_r < m && curr_c < n) {
            diagonalElements.add(mat[curr_r][curr_c]);
            curr_r++;
            curr_c++;
        }

        Collections.sort(diagonalElements);

        curr_r = r;
        curr_c = c;
        int index = 0;
        while (curr_r < m && curr_c < n) {
            mat[curr_r][curr_c] = diagonalElements.get(index);
            curr_r++;
            curr_c++;
            index++;
        }
    }
}