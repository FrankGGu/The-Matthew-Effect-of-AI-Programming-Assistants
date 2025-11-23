class Solution {
public:
    vector<int> earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        vector<int> res(2, 0);
        dfs(n, firstPlayer - 1, secondPlayer - 1, 1, res);
        return res;
    }

    void dfs(int n, int first, int second, int round, vector<int>& res) {
        if (first == second) {
            return;
        }
        if (first > second) {
            swap(first, second);
        }
        if (first < n - 1 - second) {
            dfs((n + 1) / 2, first, second - (n / 2), round + 1, res);
            return;
        }
        int m = n / 2;
        if (first == n - 1 - second) {
            if (res[0] == 0 || res[0] > round) {
                res[0] = round;
            }
            if (res[1] < round) {
                res[1] = round;
            }
            return;
        }
        int newFirst = first;
        int newSecond = n - 1 - second;
        if (newFirst > newSecond) {
            swap(newFirst, newSecond);
        }
        int newN = (n + 1) / 2;
        for (int i = newFirst + 1; i <= newSecond; ++i) {
            dfs(newN, newFirst, i, round + 1, res);
        }
    }
};