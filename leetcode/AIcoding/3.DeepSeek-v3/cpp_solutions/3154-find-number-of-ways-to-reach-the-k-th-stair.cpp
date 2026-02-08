class Solution {
public:
    int waysToReachStair(int k) {
        if (k == 0) return 1;
        if (k == 1) return 2;

        unordered_map<string, int> memo;
        return dfs(1, 1, 1, k, memo);
    }

private:
    int dfs(int pos, int jump, int canDown, int k, unordered_map<string, int>& memo) {
        if (pos == k) {
            return 1;
        }
        if (pos > k + 1) {
            return 0;
        }

        string key = to_string(pos) + "," + to_string(jump) + "," + to_string(canDown);
        if (memo.count(key)) {
            return memo[key];
        }

        int ways = 0;
        ways += dfs(pos + (1 << jump), jump + 1, 1, k, memo);

        if (canDown && pos > 0) {
            ways += dfs(pos - 1, jump, 0, k, memo);
        }

        memo[key] = ways;
        return ways;
    }
};