#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    long long notes[5];
} ATM;

ATM* atmCreate() {
    ATM* atm = (ATM*)malloc(sizeof(ATM));
    for (int i = 0; i < 5; i++) {
        atm->notes[i] = 0;
    }
    return atm;
}

void atmDeposit(ATM* obj, int banknotesCount, int banknoteType) {
    int index;
    switch (banknoteType) {
        case 20: index = 0; break;
        case 50: index = 1; break;
        case 100: index = 2; break;
        case 200: index = 3; break;
        case 500: index = 4; break;
        default: return;
    }
    obj->notes[index] += banknotesCount;
}

int* atmWithdraw(ATM* obj, int amount, int* returnSize) {
    long long withdraw[5] = {0};
    long long denominations[5] = {20, 50, 100, 200, 500};

    for (int i = 4; i >= 0; i--) {
        long long count = 0;
        if (amount >= denominations[i]) {
            count = amount / denominations[i];
            if (count > obj->notes[i]) {
                count = obj->notes[i];
            }
            withdraw[i] = count;
            amount -= count * denominations[i];
        }
    }

    if (amount != 0) {
        *returnSize = -1;
        return NULL;
    }

    int* result = (int*)malloc(5 * sizeof(int));
    for (int i = 0; i < 5; i++) {
        result[i] = withdraw[i];
        obj->notes[i] -= withdraw[i];
    }

    *returnSize = 5;
    return result;
}

void atmFree(ATM* obj) {
    free(obj);
}