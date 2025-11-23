class Solution {
public:
    int maxHappyGroups(int batchSize, vector<int>& groups) {
        vector<int> count(batchSize, 0);
        for (int g : groups) {
            count[g % batchSize]++;
        }

        int res = count[0];
        count[0] = 0;

        for (int i = 1; i < batchSize; ++i) {
            int j = batchSize - i;
            if (i == j) {
                res += count[i] / 2;
                count[i] %= 2;
            } else if (i < j) {
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

private:
    int dfs(vector<int>& count, int batchSize, int remainder, map<vector<int>, int>& memo) {
        if (memo.find(count) != memo.end()) {
            return memo[count];
        }

        int res = 0;
        for (int i = 1; i < batchSize; ++i) {
            if (count[i] == 0) continue;
            count[i]--;
            int new_remainder = (remainder + i) % batchSize;
            int current = (new_remainder == 0) ? 1 : 0;
            res = max(res, current + dfs(count, batchSize, new_remainder, memo));
            count[i]++;
        }

        memo[count] = res;
        return res;
    }
};