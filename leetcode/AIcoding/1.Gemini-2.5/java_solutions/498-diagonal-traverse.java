class Solution {
    public int[] findDiagonalOrder(int[][] mat) {
        if (mat == null || mat.length == 0 || mat[0].length == 0) {
            return new int[0];
        }

        int m = mat.length;
        int n = mat[0].length;
        int[] result = new int[m * n];
        int r = 0, c = 0;
        boolean goingUp = true; // true for up-right, false for down-left

        for (int i = 0; i < m * n; i++) {
            result[i] = mat[r][c];

            if (goingUp) {
                // Try to move up-right (r--, c++)
                // Check boundaries and change direction if necessary
                if (r == 0 && c == n - 1) { // Hit top-right corner
                    r++;
                    goingUp = false;
                } else if (r == 0) { // Hit top edge, not corner
                    c++;
                    goingUp = false;
                } else if (c == n - 1) { // Hit right edge, not corner
                    r++;
                    goingUp = false;
                } else { // Normal up-right move
                    r--;
                    c++;
                }
            } else { // goingDown (down-left: r++, c--)
                // Check boundaries and change direction if necessary
                if (r == m - 1 && c == 0) { // Hit bottom-left corner
                    c++;
                    goingUp = true;
                } else if (r == m - 1) { // Hit bottom edge, not corner
                    c++;
                    goingUp = true;
                } else if (c == 0) { // Hit left edge, not corner
                    r++;
                    goingUp = true;
                } else { // Normal down-left move
                    r++;
                    c--;
                }
            }
        }
        return result;
    }
}