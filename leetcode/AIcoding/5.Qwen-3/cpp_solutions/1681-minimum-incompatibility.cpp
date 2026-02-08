#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int minIncompatibility(vector<int>& nums, int k) {
        int n = nums.size();
        if (n % k != 0) return -1;
        int m = n / k;

        vector<vector<int>> subsets;
        vector<bool> used(n, false);

        function<void(int, int, vector<int>&)> generateSubsets = [&](int start, int count, vector<int>& curr) {
            if (count == m) {
                subsets.push_back(curr);
                return;
            }
            for (int i = start; i < n; ++i) {
                if (!used[i]) {
                    used[i] = true;
                    curr.push_back(nums[i]);
                    generateSubsets(i + 1, count + 1, curr);
                    curr.pop_back();
                    used[i] = false;
                }
            }
        };

        generateSubsets(0, 0, {});

        int size = subsets.size();
        vector<vector<int>> dp(size, vector<int>(size, INT_MAX));
        for (int i = 0; i < size; ++i) {
            int sum = 0;
            for (int num : subsets[i]) sum += num;
            dp[i][i] = sum;
        }

        for (int length = 2; length <= size; ++length) {
            for (int i = 0; i <= size - length; ++i) {
                int j = i + length - 1;
                for (int p = i; p < j; ++p) {
                    if (dp[i][p] != INT_MAX && dp[p + 1][j] != INT_MAX) {
                        dp[i][j] = min(dp[i][j], dp[i][p] + dp[p + 1][j]);
                    }
                }
            }
        }

        return dp[0][size - 1];
    }
};