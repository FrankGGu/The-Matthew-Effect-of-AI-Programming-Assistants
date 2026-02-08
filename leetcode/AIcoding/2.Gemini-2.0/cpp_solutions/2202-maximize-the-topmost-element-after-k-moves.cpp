#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumTop(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 1) {
            return (k % 2 == 0) ? nums[0] : -1;
        }

        if (k > n) {
            return *max_element(nums.begin(), nums.end());
        }

        if (k == n) {
            return *max_element(nums.begin(), nums.end() - 1);
        }

        int max_val = -1;
        for (int i = 0; i < min(k - 1, n); ++i) {
            max_val = max(max_val, nums[i]);
        }

        if (k < n) {
            max_val = max(max_val, nums[k]);
        }

        return max_val;
    }
};