#include <stdlib.h>
#include <stdbool.h>

long long matrixSumQueries(int n, int** queries, int queriesSize, int* queriesColSize) {
    long long total_sum = 0;

    bool* covered_rows = (bool*)calloc(n, sizeof(bool));
    bool* covered_cols = (bool*)calloc(n, sizeof(bool));

    int rows_covered_count = 0;
    int cols_covered_count = 0;

    for (int i = queriesSize - 1; i >= 0; --i) {
        int type = queries[i][0];
        int index = queries[i][1];
        int val = queries[i][2];

        if (type == 0) { // Row query
            if (!covered_rows[index]) {
                total_sum += (long long)val * (n - cols_covered_count);
                covered_rows[index] = true;
                rows_covered_count++;
            }
        } else { // Column query (type == 1)
            if (!covered_cols[index]) {
                total_sum += (long long)val * (n - rows_covered_count);
                covered_cols[index] = true;
                cols_covered_count++;
            }
        }

        if (rows_covered_count == n && cols_covered_count == n) {
            break;
        }
    }

    free(covered_rows);
    free(covered_cols);

    return total_sum;
}