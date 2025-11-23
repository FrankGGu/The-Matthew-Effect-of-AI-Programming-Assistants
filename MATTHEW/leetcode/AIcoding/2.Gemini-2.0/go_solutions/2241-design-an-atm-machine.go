type ATM struct {
	banknotes []int
}

func Constructor() ATM {
	return ATM{
		banknotes: make([]int, 5),
	}
}

func (this *ATM) Deposit(banknotes []int) {
	for i := 0; i < 5; i++ {
		this.banknotes[i] += banknotes[i]
	}
}

func (this *ATM) Withdraw(amount int) []int {
	values := []int{20, 50, 100, 200, 500}
	result := make([]int, 5)
	remaining := amount

	for i := 4; i >= 0; i-- {
		count := min(this.banknotes[i], remaining/values[i])
		result[i] = count
		remaining -= count * values[i]
	}

	if remaining != 0 {
		return []int{-1}
	}

	for i := 0; i < 5; i++ {
		this.banknotes[i] -= result[i]
	}

	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}