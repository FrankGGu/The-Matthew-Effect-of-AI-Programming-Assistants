class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        if (points.empty()) return 0;
        int maxPoints = 1;
        for (auto& p1 : points) {
            for (auto& p2 : points) {
                if (p1 == p2) continue;
                int xMin = min(p1[0], p2[0]);
                int xMax = max(p1[0], p2[0]);
                int yMin = min(p1[1], p2[1]);
                int yMax = max(p1[1], p2[1]);
                int count = 0;
                for (auto& p : points) {
                    if (p[0] >= xMin && p[0] <= xMax && p[1] >= yMin && p[1] <= yMax) {
                        count++;
                    }
                }
                maxPoints = max(maxPoints, count);
            }
        }
        return maxPoints;
    }
};