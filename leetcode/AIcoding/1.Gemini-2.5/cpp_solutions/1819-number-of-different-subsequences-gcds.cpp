#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int countDifferentSubsequenceGCDs(std::vector<int>& nums) {
        int max_val = 0;
        for (int num : nums) {
            if (num > max_val) {
                max_val = num;
            }
        }

        std::vector<bool> present(max_val + 1, false);
        for (int num : nums) {
            present[num] = true;
        }

        int count = 0;
        for (int g = 1; g <= max_val; ++g) {
            int sub_gcd = 0;
            for (int multiple = g; multiple <= max_val; multiple += g) {
                if (present[multiple]) {
                    if (sub_gcd == 0) {
                        sub_gcd = multiple;
                    } else {
                        sub_gcd = std::gcd(sub_gcd, multiple);
                    }
                    if (sub_gcd == g) {
                        break;
                    }
                }
            }
            if (sub_gcd == g) {
                count++;
            }
        }

        return count;
    }
};