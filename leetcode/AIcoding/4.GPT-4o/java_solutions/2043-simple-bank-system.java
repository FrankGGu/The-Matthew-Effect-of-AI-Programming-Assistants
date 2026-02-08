class Bank {
    private long[] balance;

    public Bank(long[] balance) {
        this.balance = balance;
    }

    public boolean transfer(int sender, int receiver, long amount) {
        if (sender < 1 || sender > balance.length || receiver < 1 || receiver > balance.length || balance[sender - 1] < amount) {
            return false;
        }
        balance[sender - 1] -= amount;
        balance[receiver - 1] += amount;
        return true;
    }

    public boolean deposit(int account, long amount) {
        if (account < 1 || account > balance.length) {
            return false;
        }
        balance[account - 1] += amount;
        return true;
    }

    public boolean withdraw(int account, long amount) {
        if (account < 1 || account > balance.length || balance[account - 1] < amount) {
            return false;
        }
        balance[account - 1] -= amount;
        return true;
    }
}