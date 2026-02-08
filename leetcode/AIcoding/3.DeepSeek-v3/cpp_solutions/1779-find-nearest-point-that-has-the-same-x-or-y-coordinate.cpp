class Solution {
public:
    int nearestValidPoint(int x, int y, vector<vector<int>>& points) {
        int minDist = INT_MAX;
        int index = -1;
        for (int i = 0; i < points.size(); ++i) {
            int px = points[i][0];
            int py = points[i][1];
            if (px == x || py == y) {
                int dist = abs(px - x) + abs(py - y);
                if (dist < minDist) {
                    minDist = dist;
                    index = i;
                } else if (dist == minDist && i < index) {
                    index = i;
                }
            }
        }
        return index;
    }
};