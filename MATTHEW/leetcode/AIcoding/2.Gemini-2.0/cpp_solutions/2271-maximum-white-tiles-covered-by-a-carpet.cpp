#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumWhiteTiles(vector<vector<int>>& tiles, int carpetLen) {
        sort(tiles.begin(), tiles.end());
        int n = tiles.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + (tiles[i][1] - tiles[i][0] + 1);
        }

        int maxCover = 0;
        for (int i = 0; i < n; ++i) {
            int start = tiles[i][0];
            int end = start + carpetLen - 1;
            int j = upper_bound(tiles.begin(), tiles.end(), vector<int>{end, INT_MAX}) - tiles.begin();
            int cover = prefixSum[j] - prefixSum[i];
            if (j > i) {
                cover -= max(0, tiles[j - 1][1] - end);
            }
            maxCover = max(maxCover, cover);
        }

        return maxCover;
    }
};