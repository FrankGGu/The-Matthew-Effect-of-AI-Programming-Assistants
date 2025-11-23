#include <string>

using namespace std;

class Solution {
public:
    int alternatingSubarray(vector<int>& nums) {
        int n = nums.size();
        int max_len = -1;
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i + 1] - nums[i] == 1) {
                int len = 2;
                int diff = -1;
                for (int j = i + 2; j < n; ++j) {
                    if (nums[j] - nums[j - 1] == diff) {
                        len++;
                        diff *= -1;
                    } else {
                        break;
                    }
                }
                max_len = max(max_len, len);
            }
        }
        return max_len;
    }
};