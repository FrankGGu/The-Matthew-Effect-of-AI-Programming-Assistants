#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long sumOfMatrixAfterQueries(int n, int** queries, int queriesSize, int* queriesColSize) {
    long long sum = 0;
    int row[n];
    int col[n];
    for (int i = 0; i < n; i++) {
        row[i] = 0;
        col[i] = 0;
    }
    int row_count = 0;
    int col_count = 0;

    for (int i = queriesSize - 1; i >= 0; i--) {
        int type = queries[i][0];
        int index = queries[i][1];
        int val = queries[i][2];

        if (type == 0) {
            if (row[index] == 0) {
                row[index] = 1;
                row_count++;
                for (int j = 0; j < n; j++) {
                    if (col[j] == 0) {
                        sum += val;
                    }
                }
            }
        } else {
            if (col[index] == 0) {
                col[index] = 1;
                col_count++;
                for (int j = 0; j < n; j++) {
                    if (row[j] == 0) {
                        sum += val;
                    }
                }
            }
        }
        if (row_count == n && col_count == n) break;
    }
    return sum;
}