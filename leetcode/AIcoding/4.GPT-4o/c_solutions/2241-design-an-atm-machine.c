#include <stdio.h>

struct ATM {
    long long banknotes[5];
    long long total[5];
    int denominations[5];
};

struct ATM* atmCreate() {
    struct ATM* atm = (struct ATM*)malloc(sizeof(struct ATM));
    for (int i = 0; i < 5; i++) {
        atm->banknotes[i] = 0;
        atm->total[i] = 0;
    }
    atm->denominations[0] = 20;
    atm->denominations[1] = 50;
    atm->denominations[2] = 100;
    atm->denominations[3] = 200;
    atm->denominations[4] = 500;
    return atm;
}

void atmDeposit(struct ATM* obj, int* banknotesCount, int banknotesCountSize) {
    for (int i = 0; i < banknotesCountSize; i++) {
        obj->banknotes[i] += banknotesCount[i];
        obj->total[i] += banknotesCount[i] * obj->denominations[i];
    }
}

int* atmWithdraw(struct ATM* obj, int amount, int* returnSize) {
    int* result = (int*)malloc(5 * sizeof(int));
    for (int i = 0; i < 5; i++) {
        result[i] = 0;
    }
    *returnSize = 0;

    for (int i = 4; i >= 0; i--) {
        while (amount >= obj->denominations[i] && obj->banknotes[i] > 0) {
            amount -= obj->denominations[i];
            obj->banknotes[i]--;
            result[i]++;
        }
    }

    if (amount > 0) {
        for (int i = 0; i < 5; i++) {
            obj->banknotes[i] += result[i];
            result[i] = 0;
        }
        returnSize[0] = 0;
        return result;
    }

    *returnSize = 5;
    return result;
}

void atmFree(struct ATM* obj) {
    free(obj);
}