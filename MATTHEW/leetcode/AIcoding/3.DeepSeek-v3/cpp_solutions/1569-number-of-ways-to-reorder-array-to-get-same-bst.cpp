#include <vector>
using namespace std;

class Solution {
public:
    int numOfWays(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        long long mod = 1e9 + 7;
        vector<vector<long long>> comb(n + 1, vector<long long>(n + 1, 1));
        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j < i; ++j) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % mod;
            }
        }
        return (helper(nums, comb) - 1) % mod;
    }

private:
    long long helper(vector<int>& nums, vector<vector<long long>>& comb) {
        int n = nums.size();
        if (n <= 2) return 1;
        vector<int> left, right;
        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[0]) left.push_back(nums[i]);
            else right.push_back(nums[i]);
        }
        long long l = helper(left, comb);
        long long r = helper(right, comb);
        return (((comb[n - 1][left.size()] * l) % mod) * r) % mod;
    }
};