#include <vector>

using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        int maxVal = *max_element(nums.begin(), nums.end());
        int left = -1;
        int start = -1;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == maxVal) {
                if (left == -1) {
                    left = i;
                }
                start = i;
            }

            if (left != -1) {
                ans += (long long)(start - left + 1);
            }
        }

        return ans;
    }
};