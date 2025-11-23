#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int m, n;
    scanf("%d %d", & &m, & &n);

    int grid[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", & grid[i][j]);
        }
    }

    int maxLen = 0;
    for (int startRow = 0; startRow < m; startRow++) {
        for (int startCol = 0; startCol < n; startCol++) {
            for (int k = 0; startRow + k < m && startCol + k < n; k++) {
                for (int l = 0; startRow + k + l < m && startCol - l >= 0; l++) {
                    int len = k + l;
                    int valid = 1;

                    for (int i = 1; i <= k; i++) {
                        if (grid[startRow + i][startCol + i] >= grid[startRow + i - 1][startCol + i - 1]) {
                            valid = 0;
                            break;
                        }
                    }

                    if (!valid) continue;

                    for (int i = 1; i <= l; i++) {
                        if (grid[startRow + k + i][startCol - i] >= grid[startRow + k + i - 1][startCol - (i - 1)]) {
                            valid = 0;
                            break;
                        }
                    }

                    if (!valid) continue;

                    if (len > maxLen) {
                        maxLen = len;
                    }
                }
            }
        }
    }

    return maxLen == 0 ? 0 : maxLen + 1;
}