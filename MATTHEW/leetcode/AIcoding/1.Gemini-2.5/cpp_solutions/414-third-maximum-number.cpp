#include <vector>
#include <climits> // For LLONG_MIN

class Solution {
public:
    int thirdMax(std::vector<int>& nums) {
        long long max1 = LLONG_MIN;
        long long max2 = LLONG_MIN;
        long long max3 = LLONG_MIN;

        for (int n : nums) {
            if (n > max1) {
                max3 = max2;
                max2 = max1;
                max1 = n;
            } else if (n > max2 && n != max1) {
                max3 = max2;
                max2 = n;
            } else if (n > max3 && n != max1 && n != max2) {
                max3 = n;
            }
        }

        if (max3 == LLONG_MIN) {
            return static_cast<int>(max1);
        } else {
            return static_cast<int>(max3);
        }
    }
};