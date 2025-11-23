#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    int blackBlocks(int n, int m, vector<vector<int>>& seats) {
        map<pair<int, int>, int> blockCount;
        set<pair<int, int>> blackBlocks;

        for (const auto& seat : seats) {
            int row = seat[0];
            int col = seat[1];
            for (int dr = -1; dr <= 1; ++dr) {
                for (int dc = -1; dc <= 1; ++dc) {
                    if (dr == 0 && dc == 0) continue;
                    int r = row + dr;
                    int c = col + dc;
                    if (r >= 0 && r < n && c >= 0 && c < m) {
                        pair<int, int> block = {r, c};
                        blockCount[block]++;
                    }
                }
            }
        }

        for (const auto& [pos, count] : blockCount) {
            if (count >= 1) {
                blackBlocks.insert(pos);
            }
        }

        return blackBlocks.size();
    }
};