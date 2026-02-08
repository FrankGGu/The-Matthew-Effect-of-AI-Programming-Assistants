#include <vector>

using namespace std;

class Solution {
public:
    long long matrixSumQueries(int n, vector<vector<int>>& queries) {
        vector<bool> row_filled(n, false);
        vector<bool> col_filled(n, false);
        int row_count = 0;
        int col_count = 0;
        long long sum = 0;

        for (int i = queries.size() - 1; i >= 0; --i) {
            int type = queries[i][0];
            int index = queries[i][1];
            int val = queries[i][2];

            if (type == 0) {
                if (!row_filled[index]) {
                    sum += (long long)val * (n - col_count);
                    row_filled[index] = true;
                    row_count++;
                }
            } else {
                if (!col_filled[index]) {
                    sum += (long long)val * (n - row_count);
                    col_filled[index] = true;
                    col_count++;
                }
            }

            if (row_count == n && col_count == n) {
                break;
            }
        }

        return sum;
    }
};