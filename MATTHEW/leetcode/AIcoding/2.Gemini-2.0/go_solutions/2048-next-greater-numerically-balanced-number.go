func nextBeautifulNumber(n int) int {
	for i := n + 1; ; i++ {
		if isBeautiful(i) {
			return i
		}
	}
}

func isBeautiful(n int) bool {
	counts := make(map[int]int)
	temp := n
	for temp > 0 {
		digit := temp % 10
		counts[digit]++
		temp /= 10
	}

	for digit, count := range counts {
		if digit != count {
			return false
		}
	}

	return true
}