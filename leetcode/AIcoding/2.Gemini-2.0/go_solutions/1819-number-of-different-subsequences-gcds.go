func gcd(a, b int) int {
	if b == 0 {
		return a
	}
	return gcd(b, a%b)
}

func countDifferentSubsequenceGCDs(nums []int) int {
	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	present := make([]bool, maxVal+1)
	for _, num := range nums {
		present[num] = true
	}

	count := 0
	for i := 1; i <= maxVal; i++ {
		g := 0
		for j := i; j <= maxVal; j += i {
			if present[j] {
				if g == 0 {
					g = j
				} else {
					g = gcd(g, j)
				}
			}
		}
		if g == i {
			count++
		}
	}

	return count
}