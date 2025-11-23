class Solution {
public:
    vector<int> countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
        vector<int> result;
        for (const auto& query : queries) {
            int count = 0;
            int x = query[0], y = query[1], r = query[2];
            for (const auto& point : points) {
                int dx = point[0] - x;
                int dy = point[1] - y;
                if (dx * dx + dy * dy <= r * r) {
                    count++;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};