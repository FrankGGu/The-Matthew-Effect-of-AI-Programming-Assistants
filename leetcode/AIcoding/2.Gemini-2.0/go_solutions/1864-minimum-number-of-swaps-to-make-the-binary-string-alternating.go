func minSwaps(s string) int {
	n := len(s)
	count0 := 0
	count1 := 0
	for i := 0; i < n; i++ {
		if s[i] == '0' {
			count0++
		} else {
			count1++
		}
	}

	if abs(count0-count1) > 1 {
		return -1
	}

	ans := 100001

	if count0 >= count1 {
		swaps := 0
		for i := 0; i < n; i++ {
			if i%2 == 0 && s[i] == '1' {
				swaps++
			}
		}
		ans = min(ans, swaps)
	}

	if count1 >= count0 {
		swaps := 0
		for i := 0; i < n; i++ {
			if i%2 == 0 && s[i] == '0' {
				swaps++
			}
		}
		ans = min(ans, swaps)
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}