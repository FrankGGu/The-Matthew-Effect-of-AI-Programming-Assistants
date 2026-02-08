func numberOfBeams(bank []string) int {
	ans := 0
	prev := 0
	for _, row := range bank {
		curr := 0
		for _, c := range row {
			if c == '1' {
				curr++
			}
		}
		if curr > 0 {
			ans += prev * curr
			prev = curr
		}
	}
	return ans
}