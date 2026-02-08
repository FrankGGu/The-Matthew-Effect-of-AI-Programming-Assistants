#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxNumber_of_Darts(vector<vector<int>>& darts) {
        int n = darts.size();
        if (n == 1) return 1;
        if (n == 2) return 2;

        int maxDarts = 2;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double x1 = darts[i][0], y1 = darts[i][1];
                double x2 = darts[j][0], y2 = darts[j][1];

                double dx = x2 - x1, dy = y2 - y1;
                double cx = (x1 + x2) / 2.0, cy = (y1 + y2) / 2.0;
                double r = sqrt(dx * dx + dy * dy) / 2.0;

                int count = 2;
                for (int k = 0; k < n; ++k) {
                    if (k == i || k == j) continue;
                    double dxk = darts[k][0] - cx, dyk = darts[k][1] - cy;
                    double dist = sqrt(dxk * dxk + dyk * dyk);
                    if (abs(dist - r) < 1e-8) {
                        count++;
                    }
                }
                maxDarts = max(maxDarts, count);
            }
        }

        return maxDarts;
    }
};