class Solution {
public:
    int countLatticePoints(int r, int x_center, int y_center) {
        int count = 0;
        for (int x = x_center - r; x <= x_center + r; ++x) {
            for (int y = y_center - r; y <= y_center + r; ++y) {
                if ((x - x_center) * (x - x_center) + (y - y_center) * (y - y_center) <= r * r) {
                    count++;
                }
            }
        }
        return count;
    }
};