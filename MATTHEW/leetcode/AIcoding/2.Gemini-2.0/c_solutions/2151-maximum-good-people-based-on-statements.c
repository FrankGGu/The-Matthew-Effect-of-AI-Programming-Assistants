#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int n = statementsSize;
    int maxGood = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        int goodCount = 0;
        bool valid = true;

        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) { 
                goodCount++;
            }
        }

        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) { 
                for (int j = 0; j < n; j++) {
                    if (statements[i][j] != 2) {
                        bool expected = (statements[i][j] == 1);
                        bool actual = ((mask >> j) & 1);

                        if (expected != actual) {
                            valid = false;
                            break;
                        }
                    }
                }
            }
            if (!valid) break;
        }

        if (valid) {
            if (goodCount > maxGood) {
                maxGood = goodCount;
            }
        }
    }

    return maxGood;
}