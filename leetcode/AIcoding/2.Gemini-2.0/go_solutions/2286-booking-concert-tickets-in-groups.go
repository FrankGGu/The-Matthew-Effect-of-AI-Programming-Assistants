type BookMyShow struct {
	n     int
	m     int
	seats []int
}

func Constructor(n int, m int) BookMyShow {
	seats := make([]int, n)
	for i := range seats {
		seats[i] = m
	}
	return BookMyShow{n: n, m: m, seats: seats}
}

func (this *BookMyShow) Gather(k int, maxRow int) []int {
	for i := 0; i <= maxRow; i++ {
		if this.seats[i] >= k {
			this.seats[i] -= k
			return []int{i, this.m - this.seats[i] - k}
		}
	}
	return []int{}
}

func (this *BookMyShow) Scatter(k int, maxRow int) bool {
	seatsAvailable := 0
	for i := 0; i <= maxRow; i++ {
		seatsAvailable += this.seats[i]
	}
	if seatsAvailable < k {
		return false
	}

	for i := 0; i <= maxRow; i++ {
		if this.seats[i] >= k {
			this.seats[i] -= k
			return true
		} else {
			k -= this.seats[i]
			this.seats[i] = 0
		}
	}
	return true
}