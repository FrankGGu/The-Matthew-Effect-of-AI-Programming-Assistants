class Solution {
public:
    bool checkOverlap(int radius, int x_center, int y_center, int x1, int y1, int x2, int y2) {
        double closest_x = x_center;
        double closest_y = y_center;

        if (x_center < x1) closest_x = x1;
        else if (x_center > x2) closest_x = x2;

        if (y_center < y1) closest_y = y1;
        else if (y_center > y2) closest_y = y2;

        double distance = sqrt((x_center - closest_x) * (x_center - closest_x) + (y_center - closest_y) * (y_center - closest_y));

        return distance <= radius;
    }
};