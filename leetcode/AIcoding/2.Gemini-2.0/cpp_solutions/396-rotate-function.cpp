#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxRotateFunction(vector<int>& nums) {
        int n = nums.size();
        int sum = accumulate(nums.begin(), nums.end(), 0);
        int f = 0;
        for (int i = 0; i < n; ++i) {
            f += i * nums[i];
        }
        int max_f = f;
        for (int i = 1; i < n; ++i) {
            f = f + sum - n * nums[n - i];
            max_f = max(max_f, f);
        }
        return max_f;
    }
};