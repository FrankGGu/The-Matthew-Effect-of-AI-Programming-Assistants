#include <stdlib.h>

int* supplyJewels(int* jewels, int jewelsSize, int** operations, int operationsSize, int* operationsColSize, int* returnSize) {
    for (int i = 0; i < operationsSize; i++) {
        int from_idx = operations[i][0];
        int to_idx = operations[i][1];

        int transfer_amount = jewels[from_idx] / 2;

        jewels[from_idx] -= transfer_amount;
        jewels[to_idx] += transfer_amount;
    }

    *returnSize = jewelsSize;
    return jewels;
}