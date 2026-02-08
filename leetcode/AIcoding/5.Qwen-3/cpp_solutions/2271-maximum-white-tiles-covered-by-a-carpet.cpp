#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumWhiteTiles(vector<vector<int>>& tiles, int carpetLen) {
        sort(tiles.begin(), tiles.end());
        int n = tiles.size();
        int res = 0;
        int i = 0;
        int covered = 0;
        while (i < n) {
            int start = tiles[i][0];
            int end = tiles[i][1];
            if (start + carpetLen <= end) {
                res = max(res, carpetLen);
                break;
            } else {
                covered += end - start + 1;
                if (carpetLen > end - start + 1) {
                    carpetLen -= end - start + 1;
                } else {
                    res = max(res, covered);
                    break;
                }
                i++;
            }
        }
        return res;
    }
};