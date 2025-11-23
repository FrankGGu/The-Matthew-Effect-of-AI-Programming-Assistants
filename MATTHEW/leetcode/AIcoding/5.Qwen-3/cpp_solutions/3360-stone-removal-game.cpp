#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int playGame(vector<int>& stones) {
        unordered_map<int, int> dp;
        return dfs(stones, 0, stones.size() - 1, dp);
    }

    int dfs(vector<int>& stones, int left, int right, unordered_map<int, int>& dp) {
        if (left > right) return 0;
        if (left == right) return stones[left];
        int key = left * 1000 + right;
        if (dp.find(key) != dp.end()) return dp[key];

        int pickLeft = stones[left] - dfs(stones, left + 1, right, dp);
        int pickRight = stones[right] - dfs(stones, left, right - 1, dp);

        dp[key] = max(pickLeft, pickRight);
        return dp[key];
    }
};