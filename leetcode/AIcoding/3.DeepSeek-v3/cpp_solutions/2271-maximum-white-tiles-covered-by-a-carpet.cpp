class Solution {
public:
    int maximumWhiteTiles(vector<vector<int>>& tiles, int carpetLen) {
        sort(tiles.begin(), tiles.end());
        int n = tiles.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (tiles[i][1] - tiles[i][0] + 1);
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            int end = tiles[i][0] + carpetLen - 1;
            int l = i, r = n - 1;
            int best = i;
            while (l <= r) {
                int mid = l + (r - l) / 2;
                if (tiles[mid][1] <= end) {
                    best = mid;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }

            int covered = prefix[best + 1] - prefix[i];
            if (best + 1 < n) {
                covered += max(0, end - tiles[best + 1][0] + 1);
            }
            res = max(res, covered);
        }
        return res;
    }
};