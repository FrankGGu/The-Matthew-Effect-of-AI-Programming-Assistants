#include <stdlib.h>

typedef struct {
    long long *accounts;
    int size;
} Bank;

Bank* bankCreate(int* balance, int balanceSize) {
    Bank* bank = (Bank*)malloc(sizeof(Bank));
    bank->accounts = (long long*)malloc(balanceSize * sizeof(long long));
    bank->size = balanceSize;
    for (int i = 0; i < balanceSize; i++) {
        bank->accounts[i] = balance[i];
    }
    return bank;
}

bool bankTransfer(Bank* bank, int sender, int receiver, long long amount) {
    if (sender < 1 || sender > bank->size || receiver < 1 || receiver > bank->size) {
        return false;
    }
    if (bank->accounts[sender - 1] < amount) {
        return false;
    }
    bank->accounts[sender - 1] -= amount;
    bank->accounts[receiver - 1] += amount;
    return true;
}

bool bankDeposit(Bank* bank, int account, long long amount) {
    if (account < 1 || account > bank->size) {
        return false;
    }
    bank->accounts[account - 1] += amount;
    return true;
}

bool bankWithdraw(Bank* bank, int account, long long amount) {
    if (account < 1 || account > bank->size) {
        return false;
    }
    if (bank->accounts[account - 1] < amount) {
        return false;
    }
    bank->accounts[account - 1] -= amount;
    return true;
}

void bankFree(Bank* bank) {
    free(bank->accounts);
    free(bank);
}