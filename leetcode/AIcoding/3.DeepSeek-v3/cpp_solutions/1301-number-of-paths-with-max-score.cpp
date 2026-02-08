class Solution {
public:
    vector<int> pathsWithMaxScore(vector<string>& board) {
        const int MOD = 1e9 + 7;
        int n = board.size();
        vector<vector<int>> dp_sum(n + 1, vector<int>(n + 1, 0));
        vector<vector<int>> dp_count(n + 1, vector<int>(n + 1, 0));
        board[0][0] = '0';
        board[n - 1][n - 1] = '0';
        dp_count[n - 1][n - 1] = 1;

        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (board[i][j] == 'X') continue;
                int max_sum = max({dp_sum[i + 1][j], dp_sum[i][j + 1], dp_sum[i + 1][j + 1]});
                int sum = (board[i][j] - '0') + max_sum;
                int count = 0;
                if (dp_sum[i + 1][j] == max_sum) count = (count + dp_count[i + 1][j]) % MOD;
                if (dp_sum[i][j + 1] == max_sum) count = (count + dp_count[i][j + 1]) % MOD;
                if (dp_sum[i + 1][j + 1] == max_sum) count = (count + dp_count[i + 1][j + 1]) % MOD;
                if (dp_count[i][j] != 0 || (i == n - 1 && j == n - 1)) {
                    dp_sum[i][j] = sum;
                    dp_count[i][j] = count;
                }
            }
        }
        if (dp_count[0][0] == 0) return {0, 0};
        return {dp_sum[0][0], dp_count[0][0]};
    }
};