#include <random>
#include <cmath>

class Solution {
private:
    double radius, x_center, y_center;
    std::mt19937 gen;
    std::uniform_real_distribution<> dis;

public:
    Solution(double radius, double x_center, double y_center) : radius(radius), x_center(x_center), y_center(y_center), gen(std::random_device{}()), dis(-1.0, 1.0) {}

    std::vector<double> randPoint() {
        double x, y;
        do {
            x = dis(gen);
            y = dis(gen);
        } while (x * x + y * y > 1.0);
        return {x_center + radius * x, y_center + radius * y};
    }
};