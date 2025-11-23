func smallestMissing(nums []int, value int) int {
	n := len(nums)
	cnt := make([]int, value)
	for _, x := range nums {
		cnt[(x%value+value)%value]++
	}

	seen := make(map[int]bool)
	for i := 0; ; i++ {
		mod := i % value
		if cnt[mod] > 0 {
			cnt[mod]--
		} else {
			return i
		}
		seen[i] = true
	}
}