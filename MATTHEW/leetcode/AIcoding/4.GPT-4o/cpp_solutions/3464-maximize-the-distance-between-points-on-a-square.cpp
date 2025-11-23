class Solution {
public:
    int maxDistance(vector<vector<int>>& points) {
        int n = points.size();
        int maxDist = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                maxDist = max(maxDist, abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]));
            }
        }

        return maxDist;
    }
};