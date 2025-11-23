func powerfulIntegers(x int, y int, bound int) []int {
	seen := make(map[int]bool)
	result := []int{}
	for i := 1; i <= bound; i *= x {
		for j := 1; i+j <= bound; j *= y {
			sum := i + j
			if !seen[sum] {
				result = append(result, sum)
				seen[sum] = true
			}
			if y == 1 {
				break
			}
		}
		if x == 1 {
			break
		}
	}
	return result
}