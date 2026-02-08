#include <vector>
#include <numeric>

class Bank {
private:
    std::vector<long long> accountBalances;
    int numberOfAccounts;

    bool isValidAccount(int accountNum) {
        return accountNum >= 1 && accountNum <= numberOfAccounts;
    }

public:
    Bank(std::vector<long long>& balance) {
        accountBalances = balance;
        numberOfAccounts = balance.size();
    }

    bool transfer(int account1, int account2, long long amount) {
        if (!isValidAccount(account1) || !isValidAccount(account2)) {
            return false;
        }
        if (accountBalances[account1 - 1] < amount) {
            return false;
        }
        accountBalances[account1 - 1] -= amount;
        accountBalances[account2 - 1] += amount;
        return true;
    }

    bool deposit(int account, long long amount) {
        if (!isValidAccount(account)) {
            return false;
        }
        accountBalances[account - 1] += amount;
        return true;
    }

    bool withdraw(int account, long long amount) {
        if (!isValidAccount(account)) {
            return false;
        }
        if (accountBalances[account - 1] < amount) {
            return false;
        }
        accountBalances[account - 1] -= amount;
        return true;
    }
};