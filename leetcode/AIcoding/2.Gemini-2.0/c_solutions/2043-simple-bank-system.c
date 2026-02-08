#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    long long* balance;
    int size;
} Bank;

Bank* bankCreate(long long* balance, int balanceSize) {
    Bank* obj = (Bank*)malloc(sizeof(Bank));
    obj->balance = (long long*)malloc(sizeof(long long) * balanceSize);
    for (int i = 0; i < balanceSize; i++) {
        obj->balance[i] = balance[i];
    }
    obj->size = balanceSize;
    return obj;
}

bool bankTransfer(Bank* obj, int account1, int account2, long long money) {
    if (account1 < 1 || account1 > obj->size || account2 < 1 || account2 > obj->size) {
        return false;
    }
    if (obj->balance[account1 - 1] < money) {
        return false;
    }
    obj->balance[account1 - 1] -= money;
    obj->balance[account2 - 1] += money;
    return true;
}

bool bankDeposit(Bank* obj, int account, long long money) {
    if (account < 1 || account > obj->size) {
        return false;
    }
    obj->balance[account - 1] += money;
    return true;
}

bool bankWithdraw(Bank* obj, int account, long long money) {
    if (account < 1 || account > obj->size) {
        return false;
    }
    if (obj->balance[account - 1] < money) {
        return false;
    }
    obj->balance[account - 1] -= money;
    return true;
}

void bankFree(Bank* obj) {
    free(obj->balance);
    free(obj);
}