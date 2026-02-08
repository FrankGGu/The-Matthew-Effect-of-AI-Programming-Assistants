#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
private:
    std::unordered_map<int, long long> balance;

public:
    bool transfer(int account1, int account2, long long money) {
        if (balance.find(account1) == balance.end() || balance[account1] < money) {
            return false;
        }
        balance[account1] -= money;
        balance[account2] += money;
        return true;
    }

    bool deposit(int account, long long money) {
        if (balance.find(account) == balance.end()) {
            return false;
        }
        balance[account] += money;
        return true;
    }

    bool withdraw(int account, long long money) {
        if (balance.find(account) == balance.end() || balance[account] < money) {
            return false;
        }
        balance[account] -= money;
        return true;
    }
};