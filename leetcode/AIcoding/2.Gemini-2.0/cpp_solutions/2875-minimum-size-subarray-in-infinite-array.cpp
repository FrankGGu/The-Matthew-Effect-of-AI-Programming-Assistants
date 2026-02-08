#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minSizeSubarray(vector<int>& nums, int target) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        int n = nums.size();
        long long k = target / sum;
        target %= sum;
        int ans = INT_MAX;
        int l = 0, r = 0;
        long long currSum = 0;
        while (r < 2 * n) {
            currSum += nums[r % n];
            while (currSum > target) {
                currSum -= nums[l % n];
                l++;
            }
            if (currSum == target) {
                ans = min(ans, r - l + 1);
            }
            r++;
        }
        return ans == INT_MAX ? -1 : ans + (int)(k * n);
    }
};