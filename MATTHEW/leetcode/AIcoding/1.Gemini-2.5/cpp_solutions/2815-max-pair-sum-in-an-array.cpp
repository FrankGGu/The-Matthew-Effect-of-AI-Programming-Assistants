#include <vector>
#include <string>
#include <algorithm>
#include <map>

class Solution {
public:
    int getMaxDigit(int n) {
        int maxDigit = 0;
        while (n > 0) {
            maxDigit = std::max(maxDigit, n % 10);
            n /= 10;
        }
        return maxDigit;
    }

    int maxSum(std::vector<int>& nums) {
        std::map<int, std::vector<int>> groups;
        for (int num : nums) {
            groups[getMaxDigit(num)].push_back(num);
        }

        int max_pair_sum = -1;

        for (auto const& [max_digit, group_nums] : groups) {
            if (group_nums.size() >= 2) {
                int largest1 = 0;
                int largest2 = 0;
                for (int num : group_nums) {
                    if (num > largest1) {
                        largest2 = largest1;
                        largest1 = num;
                    } else if (num > largest2) {
                        largest2 = num;
                    }
                }
                max_pair_sum = std::max(max_pair_sum, largest1 + largest2);
            }
        }

        return max_pair_sum;
    }
};