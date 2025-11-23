func findErrorNums(nums []int) []int {
	n := len(nums)
	seen := make([]bool, n+1)

	repeated := 0

	for _, num := range nums {
		if seen[num] {
			repeated = num
		}
		seen[num] = true
	}

	missing := 0
	for i := 1; i <= n; i++ {
		if !seen[i] {
			missing = i
			break
		}
	}

	return []int{repeated, missing}
}