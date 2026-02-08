class Solution {
public:
    vector<int> matrixSumQueries(int n, int m, vector<vector<int>>& queries) {
        vector<int> res;
        vector<int> row(n, 0), col(m, 0);
        int rowSum = 0, colSum = 0;
        for (int i = queries.size() - 1; i >= 0; --i) {
            int type = queries[i][0], index = queries[i][1], value = queries[i][2];
            if (type == 0) {
                if (row[index] == 0) {
                    rowSum += value;
                }
                row[index] += value;
            } else {
                if (col[index] == 0) {
                    colSum += value;
                }
                col[index] += value;
            }
            res.push_back(rowSum + colSum);
        }
        reverse(res.begin(), res.end());
        return res;
    }
};