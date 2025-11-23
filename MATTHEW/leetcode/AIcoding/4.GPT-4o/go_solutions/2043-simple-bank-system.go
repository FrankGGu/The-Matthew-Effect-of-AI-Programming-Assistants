type Bank struct {
    balance []int64
}

func Constructor(balance []int64) Bank {
    return Bank{balance: balance}
}

func (b *Bank) Transfer(sender int, receiver int, amount int64) bool {
    if sender < 1 || sender > len(b.balance) || receiver < 1 || receiver > len(b.balance) || b.balance[sender-1] < amount {
        return false
    }
    b.balance[sender-1] -= amount
    b.balance[receiver-1] += amount
    return true
}

func (b *Bank) Deposit(account int, amount int64) bool {
    if account < 1 || account > len(b.balance) {
        return false
    }
    b.balance[account-1] += amount
    return true
}

func (b *Bank) Withdraw(account int, amount int64) bool {
    if account < 1 || account > len(b.balance) || b.balance[account-1] < amount {
        return false
    }
    b.balance[account-1] -= amount
    return true
}