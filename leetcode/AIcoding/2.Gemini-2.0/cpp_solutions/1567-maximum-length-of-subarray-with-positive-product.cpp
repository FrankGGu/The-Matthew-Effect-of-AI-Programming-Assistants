#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMaxLen(vector<int>& nums) {
        int n = nums.size();
        vector<int> pos(n, 0);
        vector<int> neg(n, 0);

        if (nums[0] > 0) {
            pos[0] = 1;
        } else if (nums[0] < 0) {
            neg[0] = 1;
        }

        int maxLen = pos[0];

        for (int i = 1; i < n; ++i) {
            if (nums[i] > 0) {
                pos[i] = pos[i - 1] + 1;
                neg[i] = (neg[i - 1] > 0) ? (neg[i - 1] + 1) : 0;
            } else if (nums[i] < 0) {
                pos[i] = (neg[i - 1] > 0) ? (neg[i - 1] + 1) : 0;
                neg[i] = pos[i - 1] + 1;
            } else {
                pos[i] = 0;
                neg[i] = 0;
            }
            maxLen = max(maxLen, pos[i]);
        }

        return maxLen;
    }
};