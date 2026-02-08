#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* splitIntoFibonacci(int* sequence, int sequenceSize, int* returnSize) {
    int* result = (int*)malloc(sequenceSize * sizeof(int));
    *returnSize = 0;

    for (int i = 1; i < sequenceSize; i++) {
        if (sequence[0] > 0 && sequence[0] > INT_MAX / 10) continue;
        long a = 0;
        for (int j = 0; j < i; j++) {
            a = a * 10 + sequence[j];
            if (a > INT_MAX) break;
        }
        if (a > INT_MAX) continue;

        for (int k = i + 1; k < sequenceSize; k++) {
            if (sequence[i] > 0 && sequence[i] > INT_MAX / 10) continue;
            long b = 0;
            for (int j = i; j < k; j++) {
                b = b * 10 + sequence[j];
                if (b > INT_MAX) break;
            }
            if (b > INT_MAX) continue;

            int idx = 0;
            result[idx++] = a;
            result[idx++] = b;
            int prev = a, curr = b;
            int pos = k;
            while (pos < sequenceSize) {
                long next = prev + curr;
                if (next > INT_MAX) break;
                if (next != sequence[pos]) break;
                prev = curr;
                curr = next;
                result[idx++] = next;
                pos++;
            }

            if (pos == sequenceSize && idx <= sequenceSize) {
                *returnSize = idx;
                return result;
            }
        }
    }

    result[0] = sequence[0];
    *returnSize = 1;
    return result;
}