#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumOr(vector<int>& nums, int k) {
        int n = nums.size();
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            long long temp = nums[i];
            long long orVal = 0;
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    orVal |= nums[j];
                }
            }
            ans = max(ans, (long long)nums[i] * (1LL << k) | orVal);
        }
        return ans;
    }
};