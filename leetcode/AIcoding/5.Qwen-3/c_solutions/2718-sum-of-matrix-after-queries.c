#include <stdio.h>
#include <stdlib.h>

int sumAfterQueries(int* n, int nSize, int** queries, int queriesSize, int* queriesColSize) {
    int result = 0;
    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        for (int j = a; j <= b; j++) {
            result += n[j];
        }
    }
    return result;
}