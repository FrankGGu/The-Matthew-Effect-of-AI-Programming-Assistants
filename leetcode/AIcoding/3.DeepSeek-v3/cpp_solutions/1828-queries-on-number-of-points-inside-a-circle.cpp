class Solution {
public:
    vector<int> countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
        vector<int> res;
        for (auto& q : queries) {
            int x0 = q[0], y0 = q[1], r = q[2];
            int count = 0;
            for (auto& p : points) {
                int dx = p[0] - x0;
                int dy = p[1] - y0;
                if (dx * dx + dy * dy <= r * r) {
                    count++;
                }
            }
            res.push_back(count);
        }
        return res;
    }
};