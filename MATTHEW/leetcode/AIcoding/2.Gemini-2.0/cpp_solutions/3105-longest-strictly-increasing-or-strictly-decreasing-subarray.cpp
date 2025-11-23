#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int alternatingSubarray(vector<int>& nums) {
        int n = nums.size();
        int maxLen = -1;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                bool alternating = true;
                for (int k = i; k < j; ++k) {
                    if (nums[k + 1] - nums[k] != (k - i) % 2 == 0 ? 1 : -1) {
                        alternating = false;
                        break;
                    }
                }
                if (alternating) {
                    maxLen = max(maxLen, j - i + 1);
                }
            }
        }

        return maxLen;
    }
};