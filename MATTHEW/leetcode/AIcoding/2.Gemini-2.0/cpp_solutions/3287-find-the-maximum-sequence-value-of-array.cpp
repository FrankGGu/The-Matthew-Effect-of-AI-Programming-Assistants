#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums) {
        int n = nums.size();
        long long maxVal = -1e18;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int k = 0; k < n; ++k) {
                    long long currentVal = 1LL * nums[i] * nums[j] - nums[k];
                    maxVal = max(maxVal, currentVal);
                }
            }
        }
        return maxVal;
    }
};