class Solution {
public:
    int maxHappyGroups(int batchSize, vector<int>& groups) {
        int n = groups.size();
        vector<int> count(batchSize, 0);
        for (int num : groups) {
            count[num % batchSize]++;
        }

        int res = count[0];
        for (int i = 1; i <= batchSize / 2; ++i) {
            int j = batchSize - i;
            if (i == j) {
                res += count[i] / 2;
                count[i] %= 2;
            } else {
                int min_val = min(count[i], count[j]);
                res += min_val;
                count[i] -= min_val;
                count[j] -= min_val;
            }
        }

        map<vector<int>, int> memo;
        res += dfs(count, batchSize, 0, memo);
        return res;
    }

    int dfs(vector<int>& count, int batchSize, int remain, map<vector<int>, int>& memo) {
        if (memo.find(count) != memo.end()) {
            return memo[count];
        }

        int res = 0;
        for (int i = 1; i < batchSize; ++i) {
            if (count[i] == 0) continue;
            count[i]--;
            int new_remain = (remain + i) % batchSize;
            int temp = dfs(count, batchSize, new_remain, memo);
            if (remain == 0) {
                temp++;
            }
            res = max(res, temp);
            count[i]++;
        }

        memo[count] = res;
        return res;
    }
};