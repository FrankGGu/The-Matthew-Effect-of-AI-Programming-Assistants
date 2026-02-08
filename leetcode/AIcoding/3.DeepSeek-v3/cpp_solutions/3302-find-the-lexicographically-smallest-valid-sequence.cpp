class Solution {
public:
    vector<int> constructDistancedSequence(int n) {
        vector<int> res(2 * n - 1, 0);
        vector<bool> used(n + 1, false);
        dfs(res, used, 0, n);
        return res;
    }

    bool dfs(vector<int>& res, vector<bool>& used, int pos, int n) {
        if (pos == res.size()) {
            return true;
        }
        if (res[pos] != 0) {
            return dfs(res, used, pos + 1, n);
        }
        for (int num = n; num >= 1; --num) {
            if (used[num]) continue;
            if (num == 1) {
                res[pos] = 1;
                used[1] = true;
                if (dfs(res, used, pos + 1, n)) {
                    return true;
                }
                used[1] = false;
                res[pos] = 0;
            } else {
                if (pos + num >= res.size() || res[pos + num] != 0) continue;
                res[pos] = num;
                res[pos + num] = num;
                used[num] = true;
                if (dfs(res, used, pos + 1, n)) {
                    return true;
                }
                used[num] = false;
                res[pos] = 0;
                res[pos + num] = 0;
            }
        }
        return false;
    }
};