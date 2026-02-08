class Solution {
public:
    vector<int> countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
        vector<int> result;
        for (const auto& query : queries) {
            int count = 0;
            int x_center = query[0], y_center = query[1], radius = query[2];
            for (const auto& point : points) {
                int x = point[0], y = point[1];
                if ((x - x_center) * (x - x_center) + (y - y_center) * (y - y_center) <= radius * radius) {
                    count++;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};