class Solution {
public:
    int maxRectangle(vector<vector<int>>& points) {
        set<int> xSet;
        set<int> ySet;
        for (const auto& p : points) {
            xSet.insert(p[0]);
            ySet.insert(p[1]);
        }
        vector<int> xCoords(xSet.begin(), xSet.end());
        vector<int> yCoords(ySet.begin(), ySet.end());

        int maxArea = 0;
        for (int i = 0; i < xCoords.size(); i++) {
            for (int j = i + 1; j < xCoords.size(); j++) {
                int width = xCoords[j] - xCoords[i];
                int yMin = INT_MAX, yMax = INT_MIN;
                for (const auto& p : points) {
                    if (p[0] >= xCoords[i] && p[0] <= xCoords[j]) {
                        yMin = min(yMin, p[1]);
                        yMax = max(yMax, p[1]);
                    }
                }
                if (yMin != INT_MAX && yMax != INT_MIN) {
                    int height = yMax - yMin;
                    maxArea = max(maxArea, width * height);
                }
            }
        }
        return maxArea;
    }
};