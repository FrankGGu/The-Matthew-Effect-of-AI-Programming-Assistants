#include <vector>
#include <cmath>
#include <random>
#include <chrono>

class Solution {
private:
    double radius;
    double x_center;
    double y_center;
    std::mt19937 gen;
    std::uniform_real_distribution<double> dist_angle;
    std::uniform_real_distribution<double> dist_radius_squared_norm;

public:
    Solution(double radius, double x_center, double y_center) : 
        radius(radius), 
        x_center(x_center), 
        y_center(y_center),
        gen(std::chrono::high_resolution_clock::now().time_since_epoch().count()),
        dist_angle(0.0, 2.0 * std::acos(-1.0)), 
        dist_radius_squared_norm(0.0, 1.0)
    {}

    std::vector<double> randPoint() {
        double angle = dist_angle(gen);
        double r_norm_squared = dist_radius_squared_norm(gen);

        double r = radius * std::sqrt(r_norm_squared);

        double x = x_center + r * std::cos(angle);
        double y = y_center + r * std::sin(angle);

        return {x, y};
    }
};