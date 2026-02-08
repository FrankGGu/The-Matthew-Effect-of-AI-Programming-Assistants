class Solution {
public:
    vector<int> constructDistancedSequence(int n) {
        vector<int> result(2 * n - 1, 0);
        vector<bool> used(n + 1, false);
        backtrack(result, used, 0, n);
        return result;
    }

    bool backtrack(vector<int>& result, vector<bool>& used, int pos, int n) {
        if (pos == result.size()) {
            return true;
        }
        if (result[pos] != 0) {
            return backtrack(result, used, pos + 1, n);
        }
        for (int num = n; num >= 1; --num) {
            if (used[num]) continue;
            if (num == 1) {
                result[pos] = num;
                used[num] = true;
                if (backtrack(result, used, pos + 1, n)) {
                    return true;
                }
                used[num] = false;
                result[pos] = 0;
            } else {
                if (pos + num >= result.size() || result[pos + num] != 0) continue;
                result[pos] = num;
                result[pos + num] = num;
                used[num] = true;
                if (backtrack(result, used, pos + 1, n)) {
                    return true;
                }
                used[num] = false;
                result[pos] = 0;
                result[pos + num] = 0;
            }
        }
        return false;
    }
};