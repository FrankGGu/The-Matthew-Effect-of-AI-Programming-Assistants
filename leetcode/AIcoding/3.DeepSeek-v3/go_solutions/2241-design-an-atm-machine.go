type ATM struct {
    banknotes [5]int
    values    [5]int
}

func Constructor() ATM {
    return ATM{
        values: [5]int{20, 50, 100, 200, 500},
    }
}

func (this *ATM) Deposit(banknotesCount []int) {
    for i := 0; i < 5; i++ {
        this.banknotes[i] += banknotesCount[i]
    }
}

func (this *ATM) Withdraw(amount int) []int {
    res := make([]int, 5)
    remaining := amount
    for i := 4; i >= 0; i-- {
        if remaining == 0 {
            break
        }
        if this.banknotes[i] == 0 || this.values[i] > remaining {
            continue
        }
        cnt := remaining / this.values[i]
        if cnt > this.banknotes[i] {
            cnt = this.banknotes[i]
        }
        res[i] = cnt
        remaining -= cnt * this.values[i]
    }
    if remaining != 0 {
        return []int{-1}
    }
    for i := 0; i < 5; i++ {
        this.banknotes[i] -= res[i]
    }
    return res
}