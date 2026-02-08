#include <stdio.h>
#include <stdlib.h>

int inventoryManagement(int* stock, int stockSize, int cnt) {
    if (stock == NULL || stockSize <= 0 || cnt <= 0) return -1;
    if (cnt >= stockSize) return *stock;

    int* result = (int*)malloc(cnt * sizeof(int));
    for (int i = 0; i < cnt; i++) {
        result[i] = stock[i];
    }

    for (int i = cnt; i < stockSize; i++) {
        int j = 0;
        while (j < cnt && stock[i] > result[j]) {
            j++;
        }
        if (j < cnt) {
            for (int k = cnt - 1; k > j; k--) {
                result[k] = result[k - 1];
            }
            result[j] = stock[i];
        }
    }

    int min = result[0];
    free(result);
    return min;
}