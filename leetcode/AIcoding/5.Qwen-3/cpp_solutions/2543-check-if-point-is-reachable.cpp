#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool isReachable(vector<int>& point) {
        int x = point[0], y = point[1];
        while (x % 2 == 0 && y % 2 == 0) {
            x /= 2;
            y /= 2;
        }
        return (x % 2 == 1 && y % 2 == 1);
    }
};