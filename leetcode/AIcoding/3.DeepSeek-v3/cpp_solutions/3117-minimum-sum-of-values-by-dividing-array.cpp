class Solution {
public:
    int minimumValueSum(vector<int>& nums, vector<int>& andValues) {
        int n = nums.size();
        int m = andValues.size();
        vector<vector<unordered_map<int, int>>> dp(n, vector<unordered_map<int, int>>(m));

        function<int(int, int, int)> dfs = [&](int i, int j, int currAnd) {
            if (i == n && j == m) return 0;
            if (i == n || j == m) return -1;
            if (dp[i][j].count(currAnd)) return dp[i][j][currAnd];

            currAnd &= nums[i];
            if (currAnd < andValues[j]) return -1;

            int res = -1;
            if (currAnd == andValues[j]) {
                int next = dfs(i + 1, j + 1, ~0);
                if (next != -1) {
                    res = nums[i] + next;
                }
            }

            int next2 = dfs(i + 1, j, currAnd);
            if (next2 != -1) {
                if (res == -1 || nums[i] + next2 < res) {
                    res = nums[i] + next2;
                }
            }

            return dp[i][j][currAnd] = res;
        };

        return dfs(0, 0, ~0);
    }
};