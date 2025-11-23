#include <vector>
#include <limits> // Required for std::numeric_limits

class Solution {
public:
    bool increasingTriplet(std::vector<int>& nums) {
        long long min1 = std::numeric_limits<long long>::max();
        long long min2 = std::numeric_limits<long long>::max();

        for (int num : nums) {
            if (num <= min1) {
                min1 = num;
            } else if (num <= min2) {
                min2 = num;
            } else {
                return true;
            }
        }

        return false;
    }
};