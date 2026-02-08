#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int p) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0, right = nums[n - 1] - nums[0];
        int ans = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 0;
            for (int i = 0; i < n - 1;) {
                if (nums[i + 1] - nums[i] <= mid) {
                    count++;
                    i += 2;
                } else {
                    i++;
                }
            }

            if (count >= p) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};