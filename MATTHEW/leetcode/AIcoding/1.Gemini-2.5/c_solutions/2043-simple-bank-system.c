#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    long long* balances;
    int numAccounts;
} Bank;

Bank* bankCreate(long long* balance, int balanceSize) {
    Bank* obj = (Bank*)malloc(sizeof(Bank));
    obj->numAccounts = balanceSize;
    obj->balances = (long long*)malloc(sizeof(long long) * balanceSize);
    for (int i = 0; i < balanceSize; i++) {
        obj->balances[i] = balance[i];
    }
    return obj;
}

bool bankTransfer(Bank* obj, int account1, int account2, long long money) {
    if (account1 < 1 || account1 > obj->numAccounts ||
        account2 < 1 || account2 > obj->numAccounts) {
        return false;
    }
    if (obj->balances[account1 - 1] < money) {
        return false;
    }
    obj->balances[account1 - 1] -= money;
    obj->balances[account2 - 1] += money;
    return true;
}

bool bankDeposit(Bank* obj, int account, long long money) {
    if (account < 1 || account > obj->numAccounts) {
        return false;
    }
    obj->balances[account - 1] += money;
    return true;
}

bool bankWithdraw(Bank* obj, int account, long long money) {
    if (account < 1 || account > obj->numAccounts) {
        return false;
    }
    if (obj->balances[account - 1] < money) {
        return false;
    }
    obj->balances[account - 1] -= money;
    return true;
}

void bankFree(Bank* obj) {
    free(obj->balances);
    free(obj);
}