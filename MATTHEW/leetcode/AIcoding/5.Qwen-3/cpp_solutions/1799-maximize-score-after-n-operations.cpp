#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(1 << n, 0);
        unordered_map<int, int> memo;
        return dfs(nums, 0, dp, memo);
    }

    int dfs(vector<int>& nums, int mask, vector<int>& dp, unordered_map<int, int>& memo) {
        if (mask == (1 << nums.size()) - 1) {
            return 0;
        }
        if (dp[mask] != 0) {
            return dp[mask];
        }
        int n = nums.size();
        int maxScore = 0;
        for (int i = 0; i < n; ++i) {
            if ((mask & (1 << i)) == 0) {
                for (int j = i + 1; j < n; ++j) {
                    if ((mask & (1 << j)) == 0) {
                        int newMask = mask | (1 << i) | (1 << j);
                        int score = gcd(nums[i], nums[j]) * (n / 2 - __builtin_popcount(mask) + 1);
                        int nextScore = dfs(nums, newMask, dp, memo);
                        maxScore = max(maxScore, score + nextScore);
                    }
                }
                break;
            }
        }
        dp[mask] = maxScore;
        return maxScore;
    }

    int gcd(int a, int b) {
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};