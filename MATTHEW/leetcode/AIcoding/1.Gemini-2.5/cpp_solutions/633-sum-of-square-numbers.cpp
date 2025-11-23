#include <cmath>

class Solution {
public:
    bool judgeSquareSum(int c) {
        long long left = 0;
        long long right = static_cast<long long>(sqrt(c));

        while (left <= right) {
            long long current_sum = left * left + right * right;
            if (current_sum == c) {
                return true;
            } else if (current_sum < c) {
                left++;
            } else {
                right--;
            }
        }
        return false;
    }
};