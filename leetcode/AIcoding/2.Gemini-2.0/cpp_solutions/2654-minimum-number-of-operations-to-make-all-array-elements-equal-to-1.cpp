#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            }
        }

        if (ones > 0) {
            return n - ones;
        }

        int min_ops = INT_MAX;
        for (int i = 0; i < n; ++i) {
            int gcd_val = nums[i];
            for (int j = i + 1; j < n; ++j) {
                gcd_val = std::gcd(gcd_val, nums[j]);
                if (gcd_val == 1) {
                    min_ops = min(min_ops, j - i);
                    break;
                }
            }
        }

        if (min_ops == INT_MAX) {
            return -1;
        }

        return min_ops + n - 1;
    }
};