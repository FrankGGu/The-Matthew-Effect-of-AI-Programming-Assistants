#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* gridIllumination(int n, int** lamps, int lampsSize, int* lampsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long* row = (long long*)calloc(n, sizeof(long long));
    long long* col = (long long*)calloc(n, sizeof(long long));
    long long* diag1 = (long long*)calloc(2 * n - 1, sizeof(long long));
    long long* diag2 = (long long*)calloc(2 * n - 1, sizeof(long long));
    int* ret = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int** lamp_map = (int**)malloc(lampsSize * sizeof(int*));
    for (int i = 0; i < lampsSize; i++) {
        lamp_map[i] = (int*)malloc(2 * sizeof(int));
        lamp_map[i][0] = lamps[i][0];
        lamp_map[i][1] = lamps[i][1];
    }

    for (int i = 0; i < lampsSize; i++) {
        int r = lamps[i][0];
        int c = lamps[i][1];
        row[r]++;
        col[c]++;
        diag1[r + c]++;
        diag2[r - c + n - 1]++;
    }

    for (int i = 0; i < queriesSize; i++) {
        int r = queries[i][0];
        int c = queries[i][1];
        if (row[r] > 0 || col[c] > 0 || diag1[r + c] > 0 || diag2[r - c + n - 1] > 0) {
            ret[i] = 1;
        } else {
            ret[i] = 0;
        }

        for (int dr = -1; dr <= 1; dr++) {
            for (int dc = -1; dc <= 1; dc++) {
                int nr = r + dr;
                int nc = c + dc;
                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    for (int j = 0; j < lampsSize; j++) {
                        if (lamp_map[j][0] == nr && lamp_map[j][1] == nc) {
                            if (row[nr] > 0 && col[nc] > 0 && diag1[nr + nc] > 0 && diag2[nr - nc + n - 1] > 0) {
                                row[nr]--;
                                col[nc]--;
                                diag1[nr + nc]--;
                                diag2[nr - nc + n - 1]--;
                                lamp_map[j][0] = -1; 
                                lamp_map[j][1] = -1; 
                            }
                            break;
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < lampsSize; i++) {
        free(lamp_map[i]);
    }
    free(lamp_map);
    free(row);
    free(col);
    free(diag1);
    free(diag2);
    return ret;
}