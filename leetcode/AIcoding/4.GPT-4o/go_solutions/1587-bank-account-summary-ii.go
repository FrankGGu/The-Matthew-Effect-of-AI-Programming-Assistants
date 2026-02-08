type Bank struct {
    balance int64
}

func Constructor() Bank {
    return Bank{balance: 0}
}

func (this *Bank) Deposit(amount int64) bool {
    if amount < 0 {
        return false
    }
    this.balance += amount
    return true
}

func (this *Bank) Withdraw(amount int64) bool {
    if amount < 0 || amount > this.balance {
        return false
    }
    this.balance -= amount
    return true
}

func (this *Bank) GetBalance() int64 {
    return this.balance
}