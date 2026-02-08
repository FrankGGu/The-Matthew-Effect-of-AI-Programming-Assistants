class Solution {
public:
    bool checkStraightLine(vector<vector<int>>& coordinates) {
        if (coordinates.size() <= 2) return true;

        int x0 = coordinates[0][0], y0 = coordinates[0][1];
        int x1 = coordinates[1][0], y1 = coordinates[1][1];

        for (int i = 2; i < coordinates.size(); ++i) {
            int x = coordinates[i][0], y = coordinates[i][1];
            if ((x1 - x0) * (y - y0) != (x - x0) * (y1 - y0)) {
                return false;
            }
        }

        return true;
    }
};