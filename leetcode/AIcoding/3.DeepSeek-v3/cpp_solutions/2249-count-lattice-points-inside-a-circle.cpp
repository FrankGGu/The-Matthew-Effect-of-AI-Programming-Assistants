class Solution {
public:
    int countLatticePoints(vector<vector<int>>& circles) {
        set<pair<int, int>> points;
        for (auto& circle : circles) {
            int x = circle[0], y = circle[1], r = circle[2];
            for (int i = x - r; i <= x + r; ++i) {
                for (int j = y - r; j <= y + r; ++j) {
                    if ((i - x) * (i - x) + (j - y) * (j - y) <= r * r) {
                        points.insert({i, j});
                    }
                }
            }
        }
        return points.size();
    }
};