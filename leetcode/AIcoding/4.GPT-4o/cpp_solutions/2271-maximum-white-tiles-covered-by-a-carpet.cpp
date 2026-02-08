class Solution {
public:
    int maximumWhiteTiles(vector<vector<int>>& tiles, int carpetLen) {
        sort(tiles.begin(), tiles.end());
        int n = tiles.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (tiles[i][1] - tiles[i][0] + 1);
        }
        int maxTiles = 0, j = 0;

        for (int i = 0; i < n; ++i) {
            while (j < n && tiles[j][0] - tiles[i][0] < carpetLen) {
                j++;
            }
            int covered = prefix[j] - prefix[i];
            int leftOver = carpetLen - (tiles[j - 1][1] - tiles[i][0] + 1);
            if (leftOver > 0 && j > 0) {
                covered += min(leftOver, tiles[j - 1][1] - tiles[j - 1][0] + 1);
            }
            maxTiles = max(maxTiles, covered);
        }
        return maxTiles;
    }
};