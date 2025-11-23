class Solution {
private:
    double radius, x_center, y_center;
    std::mt19937 gen;
    std::uniform_real_distribution<double> dis;

public:
    Solution(double radius, double x_center, double y_center) : 
        radius(radius), x_center(x_center), y_center(y_center), 
        gen(std::random_device{}()), dis(0.0, 1.0) {}

    vector<double> randPoint() {
        double theta = 2 * M_PI * dis(gen);
        double r = sqrt(dis(gen)) * radius;
        return {x_center + r * cos(theta), y_center + r * sin(theta)};
    }
};