class Solution {
public:
    bool checkStraightLine(std::vector<std::vector<int>>& coordinates) {
        if (coordinates.size() <= 2) {
            return true;
        }

        int x0 = coordinates[0][0];
        int y0 = coordinates[0][1];
        int x1 = coordinates[1][0];
        int y1 = coordinates[1][1];

        int dx_ref = x1 - x0;
        int dy_ref = y1 - y0;

        for (int i = 2; i < coordinates.size(); ++i) {
            int xi = coordinates[i][0];
            int yi = coordinates[i][1];

            int dx_curr = xi - x0;
            int dy_curr = yi - y0;

            if (dy_ref * dx_curr != dy_curr * dx_ref) {
                return false;
            }
        }

        return true;
    }
};