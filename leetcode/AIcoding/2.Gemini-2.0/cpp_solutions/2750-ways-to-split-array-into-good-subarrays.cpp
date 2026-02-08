#include <vector>

using namespace std;

class Solution {
public:
    int numberOfGoodSubarraySplits(vector<int>& nums) {
        int firstOne = -1;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                firstOne = i;
                break;
            }
        }

        if (firstOne == -1) {
            return 0;
        }

        long long ans = 1;
        int mod = 1e9 + 7;
        int prevOne = firstOne;

        for (int i = firstOne + 1; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ans = (ans * (i - prevOne)) % mod;
                prevOne = i;
            }
        }

        return ans;
    }
};