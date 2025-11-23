func countTime(time string) int {
	h1, h2, m1, m2 := time[0], time[1], time[3], time[4]
	ans := 1
	if h1 == '?' && h2 == '?' {
		ans *= 24
	} else if h1 == '?' {
		if h2 <= '3' {
			ans *= 3
		} else {
			ans *= 2
		}
	} else if h2 == '?' {
		if h1 == '2' {
			ans *= 4
		} else {
			ans *= 10
		}
	}
	if m1 == '?' && m2 == '?' {
		ans *= 60
	} else if m1 == '?' {
		ans *= 6
	} else if m2 == '?' {
		ans *= 10
	}
	return ans
}