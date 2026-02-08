class Solution {
public:
    long long matrixSumQueries(int n, vector<vector<int>>& queries) {
        vector<bool> row(n, false), col(n, false);
        int row_remain = n, col_remain = n;
        long long sum = 0;

        for (int i = queries.size() - 1; i >= 0; --i) {
            int type = queries[i][0];
            int idx = queries[i][1];
            int val = queries[i][2];

            if (type == 0) {
                if (!row[idx]) {
                    sum += val * col_remain;
                    row[idx] = true;
                    row_remain--;
                }
            } else {
                if (!col[idx]) {
                    sum += val * row_remain;
                    col[idx] = true;
                    col_remain--;
                }
            }
        }

        return sum;
    }
};