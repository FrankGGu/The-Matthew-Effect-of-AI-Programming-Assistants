class Solution {
public:
    vector<vector<int>> queensAttacktheKing(vector<vector<int>>& queens, vector<int>& king) {
        vector<vector<int>> result;
        set<pair<int, int>> queenSet;
        for (auto& q : queens) {
            queenSet.insert({q[0], q[1]});
        }

        int directions[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

        for (auto& dir : directions) {
            int x = king[0], y = king[1];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (queenSet.count({x, y})) {
                    result.push_back({x, y});
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }

        return result;
    }
};