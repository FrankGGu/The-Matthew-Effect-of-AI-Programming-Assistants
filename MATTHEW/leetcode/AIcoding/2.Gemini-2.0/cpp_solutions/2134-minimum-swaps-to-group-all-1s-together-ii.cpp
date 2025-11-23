#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwaps(vector<int>& nums) {
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            }
        }

        int n = nums.size();
        int window_ones = 0;
        for (int i = 0; i < ones; ++i) {
            if (nums[i] == 1) {
                window_ones++;
            }
        }

        int max_ones = window_ones;
        for (int i = 1; i < n; ++i) {
            if (nums[i - 1] == 1) {
                window_ones--;
            }
            if (nums[(i + ones - 1) % n] == 1) {
                window_ones++;
            }
            max_ones = max(max_ones, window_ones);
        }

        return ones - max_ones;
    }
};