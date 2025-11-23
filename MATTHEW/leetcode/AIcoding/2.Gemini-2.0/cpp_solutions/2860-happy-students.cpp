#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countWays(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int count = 0;
        if (nums[0] > 0) {
            count++;
        }
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] <= i + 1 && nums[i + 1] > i + 1) {
                count++;
            }
        }
        if (nums[n - 1] <= n) {
            count++;
        }
        return count;
    }
};