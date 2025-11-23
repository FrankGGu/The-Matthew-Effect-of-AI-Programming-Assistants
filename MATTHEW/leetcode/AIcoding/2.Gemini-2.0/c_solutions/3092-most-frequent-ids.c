#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* mostFrequentIDs(int* ids, int idsSize, int* returnSize) {
    if (idsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int maxCount = 0;
    int* result = (int*)malloc(idsSize * sizeof(int));
    int resultIndex = 0;

    for (int i = 0; i < idsSize; i++) {
        int count = 0;
        for (int j = 0; j < idsSize; j++) {
            if (ids[i] == ids[j]) {
                count++;
            }
        }

        if (count > maxCount) {
            maxCount = count;
            resultIndex = 0;
            result[resultIndex++] = ids[i];
        } else if (count == maxCount) {
            int found = 0;
            for (int k = 0; k < resultIndex; k++) {
                if (result[k] == ids[i]) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                result[resultIndex++] = ids[i];
            }
        }
    }

    *returnSize = resultIndex;
    return result;
}