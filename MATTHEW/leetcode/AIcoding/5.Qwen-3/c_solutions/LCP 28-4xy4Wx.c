#include <stdio.h>
#include <stdlib.h>

int purchasePlans(int* goods, int goodsSize, int maxAmount) {
    int count = 0;
    for (int i = 0; i < goodsSize; i++) {
        for (int j = i + 1; j < goodsSize; j++) {
            if (goods[i] + goods[j] <= maxAmount) {
                count++;
            }
        }
    }
    return count;
}