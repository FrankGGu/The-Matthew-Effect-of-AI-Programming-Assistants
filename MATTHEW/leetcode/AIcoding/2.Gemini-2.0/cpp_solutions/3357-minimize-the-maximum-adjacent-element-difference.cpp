#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0;
        int right = nums[n - 1] - nums[0];
        int ans = right;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            bool possible = true;
            vector<int> temp = nums;
            for (int i = 0; i < n - 1; ++i) {
                if (temp[i + 1] - temp[i] > mid) {
                    int diff = temp[i + 1] - temp[i] - mid;
                    temp[i + 1] -= diff;
                    temp[i] += diff;
                    if (temp[i] > temp[i+1]) {
                        possible = false;
                        break;
                    }

                }
            }

            if (possible) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};