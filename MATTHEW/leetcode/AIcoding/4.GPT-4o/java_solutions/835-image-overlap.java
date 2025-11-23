class Solution {
    public int largestOverlap(int[][] A, int[][] B) {
        int n = A.length;
        int maxOverlap = 0;

        for (int xShift = -n + 1; xShift < n; xShift++) {
            for (int yShift = -n + 1; yShift < n; yShift++) {
                maxOverlap = Math.max(maxOverlap, countOverlap(A, B, xShift, yShift));
            }
        }

        return maxOverlap;
    }

    private int countOverlap(int[][] A, int[][] B, int xShift, int yShift) {
        int count = 0;
        int n = A.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i + xShift >= 0 && i + xShift < n && j + yShift >= 0 && j + yShift < n) {
                    count += A[i][j] & B[i + xShift][j + yShift];
                }
            }
        }

        return count;
    }
}