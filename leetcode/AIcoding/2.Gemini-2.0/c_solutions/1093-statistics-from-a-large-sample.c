#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double* sampleStats(int* count, int countSize) {
    double *ans = (double*)malloc(sizeof(double) * 5);
    ans[0] = -1;
    ans[1] = -1;
    double sum = 0;
    long long total = 0;
    int mode = 0;
    int maxCount = 0;
    for (int i = 0; i < countSize; i++) {
        if (count[i] > 0) {
            if (ans[0] == -1) ans[0] = i;
            ans[1] = i;
            sum += (double)i * count[i];
            total += count[i];
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
    }
    ans[2] = sum / total;
    ans[4] = mode;

    long long current = 0;
    double median = 0;
    for (int i = 0; i < countSize; i++) {
        current += count[i];
        if (total % 2 == 0) {
            if (current >= total / 2 && median == 0) {
                if (count[i] > 0) {
                    median = i;
                }
                if (current >= total / 2 + 1) {
                    ans[3] = median;
                    break;
                } else {
                    for (int j = i + 1; j < countSize; j++) {
                        if (count[j] > 0) {
                            ans[3] = (median + j) / 2.0;
                            break;
                        }
                    }
                    break;
                }
            }
        } else {
            if (current >= total / 2 + 1) {
                ans[3] = i;
                break;
            }
        }
    }

    return ans;
}