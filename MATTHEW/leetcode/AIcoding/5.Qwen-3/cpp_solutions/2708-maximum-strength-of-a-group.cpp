#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    long long maxStrength(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return nums[0];

        long long maxProduct = LLONG_MIN;
        long long minProduct = LLONG_MIN;
        long long result = LLONG_MIN;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) {
                maxProduct = 0;
                minProduct = 0;
            } else if (nums[i] > 0) {
                maxProduct = max(maxProduct * nums[i], (long long)nums[i]);
                minProduct = min(minProduct * nums[i], (long long)nums[i]);
            } else {
                long long tempMax = maxProduct;
                maxProduct = max(minProduct * nums[i], (long long)nums[i]);
                minProduct = min(tempMax * nums[i], (long long)nums[i]);
            }

            result = max(result, maxProduct);
        }

        return result;
    }
};