class Solution {
    public int maximumWhiteTiles(int[][] tiles, int carpetLen) {
        Arrays.sort(tiles, (a, b) -> a[0] - b[0]);
        int n = tiles.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (tiles[i][1] - tiles[i][0] + 1);
        }
        int max = 0;
        for (int i = 0; i < n; i++) {
            int start = tiles[i][0];
            int end = start + carpetLen - 1;
            int left = i, right = n - 1;
            int best = i;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (tiles[mid][0] <= end) {
                    best = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            int covered = prefix[best + 1] - prefix[i];
            if (best + 1 < n && tiles[best][1] < end) {
                covered += Math.max(0, end - tiles[best + 1][0] + 1);
            } else if (best < n) {
                covered = Math.min(covered, carpetLen);
            }
            max = Math.max(max, covered);
        }
        return max;
    }
}