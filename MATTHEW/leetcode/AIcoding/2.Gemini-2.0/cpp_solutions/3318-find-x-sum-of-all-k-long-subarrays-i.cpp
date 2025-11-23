#include <vector>

using namespace std;

class Solution {
public:
    long long subarrayXor(vector<int>& nums, int k, int x) {
        long long ans = 0;
        for (int i = 0; i <= nums.size() - k; ++i) {
            int xorSum = 0;
            for (int j = i; j < i + k; ++j) {
                xorSum ^= nums[j];
            }
            ans += (xorSum == x);
        }
        return ans;
    }
};