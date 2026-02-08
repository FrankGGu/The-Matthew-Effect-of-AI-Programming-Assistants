class Solution {
public:
    double minAreaFreeRect(vector<vector<int>>& points) {
        unordered_map<string, vector<vector<int>>> midpoints;
        int n = points.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                long x1 = points[i][0], y1 = points[i][1];
                long x2 = points[j][0], y2 = points[j][1];
                long dx = x1 + x2, dy = y1 + y2;
                long len = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
                string key = to_string(dx) + "," + to_string(dy) + "," + to_string(len);
                midpoints[key].push_back({x1, y1, x2, y2});
            }
        }
        double res = DBL_MAX;
        for (auto& entry : midpoints) {
            auto& vec = entry.second;
            int m = vec.size();
            for (int i = 0; i < m; ++i) {
                for (int j = i + 1; j < m; ++j) {
                    double x1 = vec[i][0], y1 = vec[i][1];
                    double x2 = vec[j][0], y2 = vec[j][1];
                    double x3 = vec[j][2], y3 = vec[j][3];
                    double area = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2)) * 
                                  sqrt(pow(x1 - x3, 2) + pow(y1 - y3, 2));
                    res = min(res, area);
                }
            }
        }
        return res == DBL_MAX ? 0 : res;
    }
};