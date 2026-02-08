class Solution {
    public boolean areSimilar(int[][] mat, int k) {
        int rows = mat.length;
        int cols = mat[0].length;

        int effectiveK = k % cols;

        if (effectiveK == 0) {
            return true;
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i % 2 == 0) { // Even-indexed row, elements shift left
                    // The element that ends up at mat[i][j] was originally at mat[i][(j + effectiveK) % cols]
                    if (mat[i][j] != mat[i][(j + effectiveK) % cols]) {
                        return false;
                    }
                } else { // Odd-indexed row, elements shift right
                    // The element that ends up at mat[i][j] was originally at mat[i][(j - effectiveK + cols) % cols]
                    if (mat[i][j] != mat[i][(j - effectiveK + cols) % cols]) {
                        return false;
                    }
                }
            }
        }

        return true;
    }
}