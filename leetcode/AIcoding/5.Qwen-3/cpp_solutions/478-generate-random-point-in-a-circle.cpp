#include <iostream>
#include <vector>
#include <cmath>
#include <cstdlib>

using namespace std;

class Solution {
private:
    double radius;
    double x_center;
    double y_center;

public:
    Solution(double radius, double x_center, double y_center) {
        this->radius = radius;
        this->x_center = x_center;
        this->y_center = y_center;
    }

    vector<double> randPoint() {
        double r = sqrt(static_cast<double>(rand()) / RAND_MAX) * radius;
        double theta = 2 * M_PI * static_cast<double>(rand()) / RAND_MAX;
        double x = x_center + r * cos(theta);
        double y = y_center + r * sin(theta);
        return {x, y};
    }
};