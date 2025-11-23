type Bank struct {
	balances    []int64
	numAccounts int
}

func Constructor(balance []int64) Bank {
	b := Bank{
		balances:    make([]int64, len(balance)),
		numAccounts: len(balance),
	}
	copy(b.balances, balance)
	return b
}

func (this *Bank) isValidAccount(account int) bool {
	return account >= 1 && account <= this.numAccounts
}

func (this *Bank) Transfer(account1 int, account2 int, money int64) bool {
	if !this.isValidAccount(account1) || !this.isValidAccount(account2) {
		return false
	}
	if this.balances[account1-1] < money {
		return false
	}

	this.balances[account1-1] -= money
	this.balances[account2-1] += money
	return true
}

func (this *Bank) Deposit(account int, money int64) bool {
	if !this.isValidAccount(account) {
		return false
	}

	this.balances[account-1] += money
	return true
}

func (this *Bank) Withdraw(account int, money int64) bool {
	if !this.isValidAccount(account) {
		return false
	}
	if this.balances[account-1] < money {
		return false
	}

	this.balances[account-1] -= money
	return true
}