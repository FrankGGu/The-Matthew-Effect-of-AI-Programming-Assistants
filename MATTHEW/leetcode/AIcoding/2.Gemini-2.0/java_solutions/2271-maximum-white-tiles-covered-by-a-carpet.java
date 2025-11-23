class Solution {
    public int maximumWhiteTiles(int[][] tiles, int carpetLen) {
        Arrays.sort(tiles, (a, b) -> a[0] - b[0]);
        int n = tiles.length;
        int ans = 0;
        int j = 0;
        int covered = 0;
        for (int i = 0; i < n; i++) {
            while (j < n && tiles[j][1] < tiles[i][0] + carpetLen) {
                covered += tiles[j][1] - tiles[j][0] + 1;
                j++;
            }
            int curCovered = covered;
            if (j < n) {
                curCovered += Math.max(0, tiles[i][0] + carpetLen - tiles[j][0]);
            }
            ans = Math.max(ans, curCovered);
            covered -= tiles[i][1] - tiles[i][0] + 1;
        }
        return ans;
    }
}