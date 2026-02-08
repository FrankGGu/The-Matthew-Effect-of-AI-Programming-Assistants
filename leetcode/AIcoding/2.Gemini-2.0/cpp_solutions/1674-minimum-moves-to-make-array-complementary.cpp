#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums, int limit) {
        int n = nums.size();
        vector<int> diff(2 * limit + 2, 0);

        for (int i = 0; i < n / 2; ++i) {
            int a = nums[i], b = nums[n - 1 - i];
            int sum = a + b;

            diff[2] += 2;
            diff[min(a, b) + 1] -= 1;
            diff[sum] -= 1;
            diff[sum + 1] += 1;
            diff[max(a, b) + limit + 1] += 1;
            diff[2 * limit + 1] -= 2;
        }

        int ans = n, curr = 0;
        for (int i = 2; i <= 2 * limit; ++i) {
            curr += diff[i];
            ans = min(ans, curr);
        }

        return ans;
    }
};