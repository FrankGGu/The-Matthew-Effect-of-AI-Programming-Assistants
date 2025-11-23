class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        unordered_set<string> pointSet;
        for (const auto& p : points) {
            pointSet.insert(to_string(p[0]) + "_" + to_string(p[1]));
        }
        int minArea = INT_MAX;
        for (int i = 0; i < points.size(); ++i) {
            for (int j = i + 1; j < points.size(); ++j) {
                if (points[i][0] != points[j][0] && points[i][1] != points[j][1]) {
                    string p1 = to_string(points[i][0]) + "_" + to_string(points[j][1]);
                    string p2 = to_string(points[j][0]) + "_" + to_string(points[i][1]);
                    if (pointSet.count(p1) && pointSet.count(p2)) {
                        int area = abs(points[i][0] - points[j][0]) * abs(points[i][1] - points[j][1]);
                        minArea = min(minArea, area);
                    }
                }
            }
        }
        return minArea == INT_MAX ? 0 : minArea;
    }
};