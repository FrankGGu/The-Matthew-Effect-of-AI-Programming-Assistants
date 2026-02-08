#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> getMaximumXor(vector<int>& nums, int maximumBit) {
        int n = nums.size();
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }

        int maxVal = (1 << maximumBit) - 1;
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = maxVal ^ xorSum;
            xorSum ^= nums[n - 1 - i];
        }

        return result;
    }
};