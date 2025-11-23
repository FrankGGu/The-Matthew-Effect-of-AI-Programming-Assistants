#include <numeric> // Required for std::gcd

class Solution {
public:
    bool isReachable(int targetX, int targetY) {
        return std::gcd(targetX, targetY) == 1;
    }
};