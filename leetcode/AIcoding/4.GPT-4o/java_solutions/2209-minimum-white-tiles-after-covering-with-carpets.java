class Solution {
    public int minimumWhiteTiles(int[] tiles, int carpetLen) {
        int n = tiles.length;
        int[] prefixSum = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + tiles[i];
        }

        int minWhiteTiles = prefixSum[n];
        for (int i = 0; i < n; i++) {
            int left = Math.max(0, i - carpetLen + 1);
            int right = i + 1;
            int covered = prefixSum[right] - prefixSum[left];
            minWhiteTiles = Math.min(minWhiteTiles, prefixSum[n] - covered);
        }

        return minWhiteTiles;
    }
}