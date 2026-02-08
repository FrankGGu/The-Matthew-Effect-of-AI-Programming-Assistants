class Bank {
public:
    vector<long long> accounts;

    Bank(vector<long long>& balance) {
        accounts = balance;
    }

    bool transfer(int sender, int receiver, long long money) {
        if (sender < 1 || receiver < 1 || sender > accounts.size() || receiver > accounts.size() || accounts[sender - 1] < money) {
            return false;
        }
        accounts[sender - 1] -= money;
        accounts[receiver - 1] += money;
        return true;
    }

    bool deposit(int account, long long money) {
        if (account < 1 || account > accounts.size()) {
            return false;
        }
        accounts[account - 1] += money;
        return true;
    }

    bool withdraw(int account, long long money) {
        if (account < 1 || account > accounts.size() || accounts[account - 1] < money) {
            return false;
        }
        accounts[account - 1] -= money;
        return true;
    }
};