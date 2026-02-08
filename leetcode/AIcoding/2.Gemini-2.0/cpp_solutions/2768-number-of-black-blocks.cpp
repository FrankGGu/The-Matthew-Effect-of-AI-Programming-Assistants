#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<long long> countBlackBlocks(int m, int n, vector<vector<int>>& coordinates) {
        unordered_map<long long, int> count;
        for (auto& coord : coordinates) {
            int x = coord[0];
            int y = coord[1];
            for (int i = 0; i < 2; ++i) {
                for (int j = 0; j < 2; ++j) {
                    int row = x - i;
                    int col = y - j;
                    if (row >= 1 && row <= m - 1 && col >= 1 && col <= n - 1) {
                        long long key = (long long)(row - 1) * (n - 1) + (col - 1);
                        count[key]++;
                    }
                }
            }
        }

        vector<long long> result(5, 0);
        for (auto& entry : count) {
            result[entry.second]++;
        }

        long long total_rects = (long long)(m - 1) * (n - 1);
        long long covered_rects = count.size();
        result[0] = total_rects - covered_rects;

        return result;
    }
};