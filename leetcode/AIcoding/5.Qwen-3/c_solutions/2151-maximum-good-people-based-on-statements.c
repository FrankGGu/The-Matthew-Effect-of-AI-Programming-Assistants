#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumGood(char** statements, int n) {
    int maxGood = 0;
    for (int mask = 0; mask < (1 << n); mask++) {
        int isCorrect = 1;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) && strcmp(statements[i], "true") == 0) {
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) && strcmp(statements[j], "false") == 0) {
                        isCorrect = 0;
                        break;
                    }
                }
            } else if ((mask & (1 << i)) && strcmp(statements[i], "false") == 0) {
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) && strcmp(statements[j], "true") == 0) {
                        isCorrect = 0;
                        break;
                    }
                }
            }
            if (!isCorrect) break;
        }
        if (isCorrect) {
            int count = 0;
            for (int i = 0; i < n; i++) {
                if (mask & (1 << i)) count++;
            }
            if (count > maxGood) maxGood = count;
        }
    }
    return maxGood;
}