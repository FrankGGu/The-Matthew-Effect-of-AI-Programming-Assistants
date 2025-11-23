#include <string>

class Solution {
public:
    std::string triangleType(int x, int y, int z) {
        if (x + y <= z || x + z <= y || y + z <= x) {
            return "None";
        }

        if (x == y && y == z) {
            return "Equilateral";
        } else if (x == y || x == z || y == z) {
            return "Isosceles";
        } else {
            return "Scalene";
        }
    }
};