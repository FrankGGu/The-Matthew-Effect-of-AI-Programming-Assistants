#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxTotalFruits(int** position, int* positionSize, int** amount, int* amountSize, int k) {
    int n = *positionSize;
    int* pos = *position;
    int* amt = *amount;

    int* sortedPos = (int*)malloc(n * sizeof(int));
    int* sortedAmt = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        sortedPos[i] = pos[i];
        sortedAmt[i] = amt[i];
    }

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (sortedPos[j] > sortedPos[j + 1]) {
                int temp = sortedPos[j];
                sortedPos[j] = sortedPos[j + 1];
                sortedPos[j + 1] = temp;

                temp = sortedAmt[j];
                sortedAmt[j] = sortedAmt[j + 1];
                sortedAmt[j + 1] = temp;
            }
        }
    }

    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + sortedAmt[i];
    }

    int result = 0;

    for (int i = 0; i < n; i++) {
        int left = i;
        int right = i;
        int total = 0;
        int steps = 0;

        while (right < n && steps <= k) {
            total += sortedAmt[right];
            steps += (sortedPos[right] - sortedPos[left]);
            if (steps <= k) {
                result = (result > total) ? result : total;
            } else {
                break;
            }
            right++;
        }

        int j = i;
        int l = i;
        int r = i;
        int sum = 0;
        int step = 0;

        while (l >= 0 && step <= k) {
            sum += sortedAmt[l];
            step += (sortedPos[r] - sortedPos[l]);
            if (step <= k) {
                result = (result > sum) ? result : sum;
            } else {
                break;
            }
            l--;
        }

        j = i;
        l = i;
        r = i;
        sum = 0;
        step = 0;

        while (r < n && step <= k) {
            sum += sortedAmt[r];
            step += (sortedPos[r] - sortedPos[l]);
            if (step <= k) {
                result = (result > sum) ? result : sum;
            } else {
                break;
            }
            r++;
        }
    }

    free(sortedPos);
    free(sortedAmt);
    free(prefix);

    return result;
}