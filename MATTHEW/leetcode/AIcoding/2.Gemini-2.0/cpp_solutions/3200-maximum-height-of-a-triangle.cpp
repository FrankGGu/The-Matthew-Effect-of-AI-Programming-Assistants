#include <cmath>

class Solution {
public:
    int largestTriangleArea(int base, int area) {
        return (2 * area + base - 1) / base;
    }
};