class Solution {
    public boolean findRotation(int[][] mat, int[][] target) {
        int n = mat.length;

        boolean rot0 = true;   // Check for 0 degrees rotation
        boolean rot90 = true;  // Check for 90 degrees clockwise rotation
        boolean rot180 = true; // Check for 180 degrees clockwise rotation
        boolean rot270 = true; // Check for 270 degrees clockwise rotation

        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                // Check 0 degrees rotation: mat[r][c] == target[r][c]
                if (mat[r][c] != target[r][c]) {
                    rot0 = false;
                }
                // Check 90 degrees clockwise rotation: mat[r][c] == target[c][n - 1 - r]
                if (mat[r][c] != target[c][n - 1 - r]) {
                    rot90 = false;
                }
                // Check 180 degrees clockwise rotation: mat[r][c] == target[n - 1 - r][n - 1 - c]
                if (mat[r][c] != target[n - 1 - r][n - 1 - c]) {
                    rot180 = false;
                }
                // Check 270 degrees clockwise rotation: mat[r][c] == target[n - 1 - c][r]
                if (mat[r][c] != target[n - 1 - c][r]) {
                    rot270 = false;
                }
            }
        }

        return rot0 || rot90 || rot180 || rot270;
    }
}