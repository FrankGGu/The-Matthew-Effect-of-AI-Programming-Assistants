class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        if (n <= 2) return n;

        int maxPoints = 2;
        for (int i = 0; i < n; i++) {
            unordered_map<double, int> slopeCount;
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    double slope = (points[j][0] == points[i][0]) ? 
                                   numeric_limits<double>::infinity() : 
                                   static_cast<double>(points[j][1] - points[i][1]) / 
                                   (points[j][0] - points[i][0]);
                    slopeCount[slope]++;
                }
            }
            for (auto& [slope, count] : slopeCount) {
                maxPoints = max(maxPoints, count + 1);
            }
        }
        return maxPoints;
    }
};