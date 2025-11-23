#include <vector>
#include <utility>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> queensAttacktheKing(vector<vector<int>>& queens, vector<int>& king) {
        vector<vector<int>> result;
        unordered_map<int, int> queenSet;
        for (auto& q : queens) {
            queenSet[q[0] * 8 + q[1]] = 1;
        }

        int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; ++i) {
            int x = king[0], y = king[1];
            while (true) {
                x += dx[i];
                y += dy[i];
                if (x < 0 || x >= 8 || y < 0 || y >= 8) break;
                int key = x * 8 + y;
                if (queenSet.find(key) != queenSet.end()) {
                    result.push_back({x, y});
                    break;
                }
            }
        }

        return result;
    }
};