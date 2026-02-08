#include <iostream>
#include <vector>
#include <cmath>
#include <limits>

using namespace std;

class Solution {
public:
    double getMinAverageDistance(vector<vector<int>>& positions) {
        double left = -1e5, right = 1e5;
        for (int i = 0; i < 100; ++i) {
            double mid1 = left + (right - left) / 3;
            double mid2 = right - (right - left) / 3;
            double d1 = calculateDistance(positions, mid1);
            double d2 = calculateDistance(positions, mid2);
            if (d1 < d2) {
                right = mid2;
            } else {
                left = mid1;
            }
        }
        return calculateDistance(positions, (left + right) / 2);
    }

private:
    double calculateDistance(vector<vector<int>>& positions, double x) {
        double total = 0.0;
        for (const auto& pos : positions) {
            total += sqrt((pos[0] - x) * (pos[0] - x) + (pos[1] - x) * (pos[1] - x));
        }
        return total / positions.size();
    }
};