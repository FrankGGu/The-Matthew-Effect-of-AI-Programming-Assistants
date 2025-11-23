#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int accountNumber;
    long long balance;
} Bank;

Bank* bankCreate(long long* accounts, int accountsSize) {
    Bank* bank = (Bank*)malloc(sizeof(Bank));
    bank->accountNumber = 0;
    bank->balance = 0;
    return bank;
}

bool bankAddAccount(Bank* obj, int accountNumber, long long initialBalance) {
    if (obj->accountNumber != 0) {
        return false;
    }
    obj->accountNumber = accountNumber;
    obj->balance = initialBalance;
    return true;
}

bool bankTransfer(Bank* obj, int fromAccountNumber, int toAccountNumber, long long amount) {
    if (obj->accountNumber != fromAccountNumber || obj->balance < amount) {
        return false;
    }
    obj->balance -= amount;
    return true;
}

bool bankDeposit(Bank* obj, int accountNumber, long long amount) {
    if (obj->accountNumber != accountNumber) {
        return false;
    }
    obj->balance += amount;
    return true;
}

long long bankCheckBalance(Bank* obj, int accountNumber) {
    if (obj->accountNumber != accountNumber) {
        return -1;
    }
    return obj->balance;
}

void bankFree(Bank* obj) {
    free(obj);
}