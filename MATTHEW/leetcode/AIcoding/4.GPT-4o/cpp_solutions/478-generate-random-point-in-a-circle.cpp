class Solution {
public:
    double radius, x_center, y_center;

    Solution(double radius, double x_center, double y_center) {
        this->radius = radius;
        this->x_center = x_center;
        this->y_center = y_center;
    }

    vector<double> randPoint() {
        double angle = ((double)rand() / RAND_MAX) * 2 * M_PI;
        double r = sqrt((double)rand() / RAND_MAX) * radius;
        double x = x_center + r * cos(angle);
        double y = y_center + r * sin(angle);
        return {x, y};
    }
};