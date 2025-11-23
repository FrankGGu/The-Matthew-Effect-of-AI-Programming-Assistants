class Solution {
    public boolean isPrintable(int[][] targetGrid) {
        int m = targetGrid.length, n = targetGrid[0].length;
        int[] left = new int[61], right = new int[61], top = new int[61], bottom = new int[61];
        boolean[] seen = new boolean[61];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int num = targetGrid[i][j];
                if (num == 0) continue;
                seen[num] = true;
                left[num] = Math.min(left[num] == 0 ? n : left[num], j);
                right[num] = Math.max(right[num], j);
                top[num] = Math.min(top[num] == 0 ? m : top[num], i);
                bottom[num] = Math.max(bottom[num], i);
            }
        }

        for (int k = 1; k <= 60; k++) {
            if (!seen[k]) continue;
            for (int i = top[k]; i <= bottom[k]; i++) {
                for (int j = left[k]; j <= right[k]; j++) {
                    if (targetGrid[i][j] != k && targetGrid[i][j] != 0) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}