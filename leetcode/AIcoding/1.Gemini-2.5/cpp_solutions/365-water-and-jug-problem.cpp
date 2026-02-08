#include <numeric> // Required for std::gcd in C++17

class Solution {
public:
    bool canMeasureWater(int jug1Capacity, int jug2Capacity, int targetCapacity) {
        if (targetCapacity == 0) {
            return true;
        }
        if (jug1Capacity + jug2Capacity < targetCapacity) {
            return false;
        }

        // The greatest common divisor (GCD) of jug1Capacity and jug2Capacity
        // determines the smallest measurable unit. Any amount measurable
        // must be a multiple of this GCD.
        // std::gcd is available in C++17.
        int common_divisor = std::gcd(jug1Capacity, jug2Capacity);

        return targetCapacity % common_divisor == 0;
    }
};