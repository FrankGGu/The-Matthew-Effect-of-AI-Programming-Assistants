#include <vector>
#include <cmath>
#include <algorithm>
#include <random>

using namespace std;

class Solution {
public:
    double getMinDistSum(vector<vector<int>>& positions) {
        double left = 100, right = 0, bottom = 100, top = 0;
        for (auto& pos : positions) {
            left = min(left, (double)pos[0]);
            right = max(right, (double)pos[0]);
            bottom = min(bottom, (double)pos[1]);
            top = max(top, (double)pos[1]);
        }
        double res = DBL_MAX, res_x = 0, res_y = 0;
        for (double delta = 10; delta >= 1e-5; delta /= 10) {
            for (int i = 0; i < 100; ++i) {
                for (double x = left; x <= right; x += delta) {
                    for (double y = bottom; y <= top; y += delta) {
                        double d = 0;
                        for (auto& pos : positions) {
                            d += sqrt((x - pos[0]) * (x - pos[0]) + (y - pos[1]) * (y - pos[1]));
                        }
                        if (d < res) {
                            res = d;
                            res_x = x;
                            res_y = y;
                        }
                    }
                }
                left = res_x - delta;
                right = res_x + delta;
                bottom = res_y - delta;
                top = res_y + delta;
            }
        }
        return res;
    }
};