func countDistinct(nums []int, k int, p int) int {
	n := len(nums)
	seen := make(map[string]bool)
	count := 0
	for i := 0; i < n; i++ {
		divisibleCount := 0
		subarray := []int{}
		for j := i; j < n; j++ {
			subarray = append(subarray, nums[j])
			if nums[j]%p == 0 {
				divisibleCount++
			}
			if divisibleCount > k {
				break
			}
			key := arrayToString(subarray)
			if !seen[key] {
				seen[key] = true
				count++
			}
		}
	}
	return count
}

func arrayToString(arr []int) string {
	s := ""
	for _, num := range arr {
		s += string(rune(num)) + ","
	}
	return s
}