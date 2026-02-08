func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func countArrayPairs(nums []int, k int) int {
	count := 0
	freq := make(map[int]int)

	for _, num := range nums {
		g := gcd(num, k)
		freq[g]++
	}

	for g1, c1 := range freq {
		for g2, c2 := range freq {
			if g1 <= g2 && (g1*g2)%k == 0 {
				if g1 == g2 {
					count += c1 * (c1 - 1) / 2
				} else {
					count += c1 * c2
				}
			}
		}
	}

	return count
}