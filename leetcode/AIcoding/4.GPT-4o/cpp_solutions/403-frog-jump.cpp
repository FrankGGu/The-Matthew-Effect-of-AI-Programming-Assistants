class Solution {
public:
    bool canCross(vector<int>& stones) {
        int n = stones.size();
        if (n == 0 || stones[0] != 0) return false;
        unordered_map<int, unordered_set<int>> dp;
        for (int stone : stones) {
            dp[stone] = unordered_set<int>();
        }
        dp[0].insert(0);

        for (int stone : stones) {
            for (int k : dp[stone]) {
                for (int jump = k - 1; jump <= k + 1; ++jump) {
                    if (jump > 0 && dp.count(stone + jump)) {
                        dp[stone + jump].insert(jump);
                    }
                }
            }
        }
        return !dp[stones.back()].empty();
    }
};