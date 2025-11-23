#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeArrayLength(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        long long sum = 0;
        for (int i = 0; i < n - 1; ++i) {
            sum += nums[i];
        }

        if (sum < nums[n - 1]) {
            return n - (n - 1);
        } else {
            return (n + 1) / 2;
        }
    }
};