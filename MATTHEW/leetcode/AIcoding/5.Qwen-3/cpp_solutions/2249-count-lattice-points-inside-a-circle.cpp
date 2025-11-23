#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int countLatticePoints(int n, vector<vector<int>>& circles) {
        int count = 0;
        for (int x = 0; x <= 200; ++x) {
            for (int y = 0; y <= 200; ++y) {
                bool inside = false;
                for (const auto& circle : circles) {
                    int cx = circle[0];
                    int cy = circle[1];
                    int r = circle[2];
                    if ((x - cx) * (x - cx) + (y - cy) * (y - cy) < r * r) {
                        inside = true;
                        break;
                    }
                }
                if (inside) {
                    ++count;
                }
            }
        }
        return count;
    }
};