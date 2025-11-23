#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canSortArray(vector<int>& nums) {
        int n = nums.size();
        int i = 0;
        while (i < n) {
            int j = i;
            int bit_count = __builtin_popcount(nums[i]);
            while (j + 1 < n && __builtin_popcount(nums[j + 1]) == bit_count) {
                j++;
            }
            sort(nums.begin() + i, nums.begin() + j + 1);
            i = j + 1;
        }

        for (int i = 1; i < n; i++) {
            if (nums[i] < nums[i - 1]) {
                return false;
            }
        }

        return true;
    }
};