package main

type ATM struct {
	bills  []int
	counts []int
}

func Constructor() ATM {
	return ATM{
		bills:  []int{20, 50, 100, 200, 500},
		counts: []int{0, 0, 0, 0, 0},
	}
}

func (this *ATM) Deposit(bill int, count int) {
	for i := 0; i < len(this.bills); i++ {
		if this.bills[i] == bill {
			this.counts[i] += count
			return
		}
	}
}

func (this *ATM) Withdraw(amount int) []int {
	remaining := amount
	result := make([]int, len(this.bills))
	copy(result, this.counts)

	for i := len(this.bills) - 1; i >= 0; i-- {
		bill := this.bills[i]
		if remaining >= bill && result[i] > 0 {
			num := min(remaining/bill, result[i])
			result[i] -= num
			remaining -= num * bill
		}
	}

	if remaining == 0 {
		for i := 0; i < len(this.bills); i++ {
			this.counts[i] = result[i]
		}
		return result
	}

	return []int{}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}