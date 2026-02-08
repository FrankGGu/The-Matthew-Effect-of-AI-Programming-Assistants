#include <vector>
#include <numeric>
#include <string>

class Solution {
public:
    int countBeautifulPairs(std::vector<int>& nums) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int first_digit = nums[i];
            while (first_digit >= 10) {
                first_digit /= 10;
            }
            for (int j = i + 1; j < n; ++j) {
                int last_digit = nums[j] % 10;
                if (std::gcd(first_digit, last_digit) == 1) {
                    count++;
                }
            }
        }
        return count;
    }
};