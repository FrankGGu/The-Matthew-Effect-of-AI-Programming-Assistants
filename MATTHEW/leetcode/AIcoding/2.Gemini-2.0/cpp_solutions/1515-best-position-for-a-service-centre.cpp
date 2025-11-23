#include <vector>
#include <cmath>
#include <iomanip>

using namespace std;

class Solution {
public:
    double getMinDistSum(vector<vector<int>>& positions) {
        double x = 0.0, y = 0.0;
        int n = positions.size();
        for (auto& pos : positions) {
            x += pos[0];
            y += pos[1];
        }
        x /= n;
        y /= n;

        double step = 100.0;
        double eps = 1e-6;

        while (step > eps) {
            double minDist = calculateDistanceSum(positions, x, y);
            double nextX = x, nextY = y;

            double dx[] = {step, -step, 0, 0};
            double dy[] = {0, 0, step, -step};

            for (int i = 0; i < 4; ++i) {
                double newX = x + dx[i];
                double newY = y + dy[i];
                double newDist = calculateDistanceSum(positions, newX, newY);
                if (newDist < minDist) {
                    minDist = newDist;
                    nextX = newX;
                    nextY = newY;
                }
            }

            if (nextX == x && nextY == y) {
                step /= 2.0;
            } else {
                x = nextX;
                y = nextY;
            }
        }

        return calculateDistanceSum(positions, x, y);
    }

private:
    double calculateDistanceSum(vector<vector<int>>& positions, double x, double y) {
        double sum = 0.0;
        for (auto& pos : positions) {
            sum += sqrt(pow(pos[0] - x, 2) + pow(pos[1] - y, 2));
        }
        return sum;
    }
};