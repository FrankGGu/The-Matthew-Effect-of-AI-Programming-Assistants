import java.util.Arrays;

public class Solution {
    public int maximumWhiteTiles(int[][] tiles, int carpetLen) {
        Arrays.sort(tiles, (a, b) -> a[0] - b[0]);
        int n = tiles.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + (tiles[i][1] - tiles[i][0] + 1);
        }

        int maxTiles = 0;
        for (int i = 0; i < n; i++) {
            int start = tiles[i][0];
            int end = start + carpetLen - 1;
            int j = binarySearch(tiles, end);
            int totalTiles = prefixSum[j + 1] - prefixSum[i];
            if (j > i) {
                int excess = Math.max(0, end - tiles[j][0] + 1);
                totalTiles -= Math.max(0, tiles[j][1] - tiles[j][0] + 1 - excess);
            }
            maxTiles = Math.max(maxTiles, totalTiles);
        }
        return maxTiles;
    }

    private int binarySearch(int[][] tiles, int target) {
        int left = 0, right = tiles.length - 1;
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (tiles[mid][0] <= target) left = mid;
            else right = mid - 1;
        }
        return left;
    }
}