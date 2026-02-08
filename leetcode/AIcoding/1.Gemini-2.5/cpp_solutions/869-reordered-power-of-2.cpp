#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    bool reorderedPowerOf2(int n) {
        std::vector<int> n_counts = countDigits(n);

        // Iterate through powers of 2.
        // n is up to 10^9.
        // 2^0 = 1
        // ...
        // 2^29 = 536,870,912 (9 digits)
        // 2^30 = 1,073,741,824 (10 digits)
        // The largest n is 10^9, which has 10 digits.
        // So we need to check powers of 2 that have up to 10 digits.
        // 2^30 is the largest power of 2 that can be formed from digits of a number <= 10^9.
        for (int i = 0; i <= 30; ++i) {
            int power_of_2 = 1 << i;
            std::vector<int> p2_counts = countDigits(power_of_2);
            if (n_counts == p2_counts) {
                return true;
            }
        }
        return false;
    }

private:
    // Helper function to count digit frequencies of a number
    std::vector<int> countDigits(int num) {
        std::vector<int> counts(10, 0);
        while (num > 0) {
            counts[num % 10]++;
            num /= 10;
        }
        return counts;
    }
};