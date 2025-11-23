#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* banknotes;
    int* denominations;
    int size;
} ATM;

ATM* atmCreate(int* denominations, int denominationsSize) {
    ATM* atm = (ATM*)malloc(sizeof(ATM));
    atm->banknotes = (int*)calloc(denominationsSize, sizeof(int));
    atm->denominations = denominations;
    atm->size = denominationsSize;
    return atm;
}

void atmDeposit(ATM* obj, int* banknotesCount, int banknotesCountSize) {
    for (int i = 0; i < banknotesCountSize; i++) {
        obj->banknotes[i] += banknotesCount[i];
    }
}

int* atmWithdraw(ATM* obj, int amount, int* returnSize) {
    int* result = (int*)calloc(obj->size, sizeof(int));
    int remaining = amount;
    for (int i = obj->size - 1; i >= 0 && remaining > 0; i--) {
        int count = remaining / obj->denominations[i];
        if (count > 0 && obj->banknotes[i] >= count) {
            result[i] = count;
            obj->banknotes[i] -= count;
            remaining -= count * obj->denominations[i];
        }
    }
    if (remaining == 0) {
        *returnSize = obj->size;
        return result;
    } else {
        free(result);
        *returnSize = 0;
        return NULL;
    }
}

void atmFree(ATM* obj) {
    free(obj->banknotes);
    free(obj->denominations);
    free(obj);
}