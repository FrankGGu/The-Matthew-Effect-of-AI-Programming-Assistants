func findErrorNums(nums []int) []int {
	n := len(nums)
	seen := make([]bool, n+1)

	duplicate := 0
	missing := 0

	for _, num := range nums {
		if seen[num] {
			duplicate = num
		}
		seen[num] = true
	}

	for i := 1; i <= n; i++ {
		if !seen[i] {
			missing = i
			break
		}
	}

	return []int{duplicate, missing}
}