type ATM struct {
	denominations []int
	balance       []int
}

func Constructor() ATM {
	return ATM{
		denominations: []int{20, 50, 100, 200, 500},
		balance:       make([]int, 5),
	}
}

func (this *ATM) Deposit(banknotesCount []int) {
	for i := 0; i < 5; i++ {
		this.balance[i] += banknotesCount[i]
	}
}

func (this *ATM) Withdraw(amount int) []int {
	if amount%20 != 0 {
		return []int{-1}
	}
	result := make([]int, 5)
	for i := 4; i >= 0; i-- {
		if amount == 0 {
			break
		}
		count := min(amount/this.denominations[i], this.balance[i])
		result[i] = count
		this.balance[i] -= count
		amount -= count * this.denominations[i]
	}
	if amount > 0 {
		for i := 0; i < 5; i++ {
			this.balance[i] += result[i]
		}
		return []int{-1}
	}
	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}