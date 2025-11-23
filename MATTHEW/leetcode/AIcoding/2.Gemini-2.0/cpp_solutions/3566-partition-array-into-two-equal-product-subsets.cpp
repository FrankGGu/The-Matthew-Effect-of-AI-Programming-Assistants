#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool canPartition(vector<int>& nums) {
        long long totalProduct = 1;
        for (int num : nums) {
            totalProduct *= num;
        }

        if (totalProduct == 0) {
            int zeroCount = 0;
            for (int num : nums) {
                if (num == 0) {
                    zeroCount++;
                }
            }
            return zeroCount > 0;
        }

        int n = nums.size();
        for (int i = 0; i < (1 << n); ++i) {
            long long subsetProduct = 1;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    subsetProduct *= nums[j];
                }
            }

            if (subsetProduct * subsetProduct == totalProduct) {
                return true;
            }
        }

        return false;
    }
};