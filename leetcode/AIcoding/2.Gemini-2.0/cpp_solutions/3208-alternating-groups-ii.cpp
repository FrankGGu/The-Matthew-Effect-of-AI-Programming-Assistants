#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int alternatingSubarray(vector<int>& nums) {
        int maxLen = -1;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                int len = j - i + 1;
                bool valid = true;
                for (int k = i; k <= j; ++k) {
                    if ((nums[k] - nums[i]) != (k - i) % 2) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    maxLen = max(maxLen, len);
                }
            }
        }
        return maxLen;
    }
};