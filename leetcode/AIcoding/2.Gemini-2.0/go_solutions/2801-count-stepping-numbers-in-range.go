func countSteppingNumbers(low int, high int) int {
	var ans int
	var q []int
	for i := 1; i <= 9; i++ {
		q = append(q, i)
	}

	var bfs func(int)
	bfs = func(n int) {
		if n >= low && n <= high {
			ans++
		}
		if n > high {
			return
		}

		lastDigit := n % 10
		if lastDigit > 0 {
			nextNum := n*10 + (lastDigit - 1)
			if nextNum <= high {
				q = append(q, nextNum)
			}
		}
		if lastDigit < 9 {
			nextNum := n*10 + (lastDigit + 1)
			if nextNum <= high {
				q = append(q, nextNum)
			}
		}
	}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		bfs(curr)
	}

	if low == 0 {
		ans++
	}

	return ans
}