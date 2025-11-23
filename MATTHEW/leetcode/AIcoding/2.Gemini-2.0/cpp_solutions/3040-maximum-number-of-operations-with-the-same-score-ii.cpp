#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int n = nums.size();
        unordered_map<string, int> memo;

        function<int(int, int, int)> solve = [&](int i, int j, int target) {
            if (i >= j) return 0;

            string key = to_string(i) + "_" + to_string(j) + "_" + to_string(target);
            if (memo.count(key)) return memo[key];

            int ans = 0;

            if (nums[i] + nums[i+1] == target) {
                ans = max(ans, 1 + solve(i + 2, j, target));
            }
            if (nums[j] + nums[j-1] == target) {
                ans = max(ans, 1 + solve(i, j - 2, target));
            }
            if (nums[i] + nums[j] == target) {
                ans = max(ans, 1 + solve(i + 1, j - 1, target));
            }

            return memo[key] = ans;
        };

        int ans = 0;
        ans = max(ans, 1 + solve(2, n - 1, nums[0] + nums[1]));
        ans = max(ans, 1 + solve(1, n - 2, nums[0] + nums[n-1]));
        ans = max(ans, 1 + solve(0, n - 3, nums[n-2] + nums[n-1]));

        return ans;
    }
};