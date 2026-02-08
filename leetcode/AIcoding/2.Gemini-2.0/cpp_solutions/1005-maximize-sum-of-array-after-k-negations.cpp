#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestSumAfterKNegations(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());

        int n = nums.size();
        for (int i = 0; i < n && k > 0; ++i) {
            if (nums[i] < 0) {
                nums[i] = -nums[i];
                k--;
            } else {
                break;
            }
        }

        if (k % 2 == 1) {
            sort(nums.begin(), nums.end());
            nums[0] = -nums[0];
        }

        int sum = 0;
        for (int num : nums) {
            sum += num;
        }

        return sum;
    }
};