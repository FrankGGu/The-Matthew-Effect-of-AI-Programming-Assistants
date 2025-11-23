#include <vector>

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
            for (int k = i; k < j; k++) {
                for (int l = i; l < j; l++) {
                    if (nums[l] > nums[l + 1]) {
                        swap(nums[l], nums[l + 1]);
                    }
                }
            }
            i = j + 1;
        }
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] > nums[i + 1]) {
                return false;
            }
        }
        return true;
    }
};