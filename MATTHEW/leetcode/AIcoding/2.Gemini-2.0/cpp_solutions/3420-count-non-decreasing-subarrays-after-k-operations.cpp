#include <vector>

using namespace std;

class Solution {
public:
    int countNonDecreasingSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        long long ans = 0;
        int left = 0;
        int operations = 0;

        for (int right = 0; right < n; ++right) {
            while (left < right) {
                int cost = 0;
                for (int i = left + 1; i <= right; ++i) {
                    cost += max(0, nums[i - 1] - nums[i]);
                }
                if (cost > k) {
                    left++;
                } else {
                    break;
                }
            }
            ans += (right - left + 1);
        }

        return ans;
    }
};