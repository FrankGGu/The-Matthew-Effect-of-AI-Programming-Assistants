#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        if (points.empty()) return 0;
        if (points.size() == 1) return 1;

        int maxPoints = 0;

        for (int i = 0; i < points.size(); ++i) {
            map<pair<int, int>, int> slopeCount;
            int samePoint = 0;
            int currentMax = 0;

            for (int j = 0; j < points.size(); ++j) {
                if (i == j) continue;
                int dx = points[j][0] - points[i][0];
                int dy = points[j][1] - points[i][1];

                if (dx == 0 && dy == 0) {
                    samePoint++;
                    continue;
                }

                int gcdVal = gcd(dx, dy);
                dx /= gcdVal;
                dy /= gcdVal;

                if (dx < 0) {
                    dx = -dx;
                    dy = -dy;
                } else if (dx == 0) {
                    dy = abs(dy);
                } else if (dy < 0) {
                    dy = -dy;
                }

                slopeCount[{dx, dy}]++;
                currentMax = max(currentMax, slopeCount[{dx, dy}]);
            }

            maxPoints = max(maxPoints, currentMax + samePoint + 1);
        }

        return maxPoints;
    }

private:
    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};