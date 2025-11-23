func divideArray(nums []int, k int) bool {
	if len(nums)%k != 0 {
		return false
	}
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}
	keys := make([]int, 0, len(counts))
	for key := range counts {
		keys = append(keys, key)
	}
	sort.Ints(keys)
	for _, key := range keys {
		if counts[key] > 0 {
			count := counts[key]
			for i := 0; i < k; i++ {
				num := key + i
				if counts[num] < count {
					return false
				}
				counts[num] -= count
			}
		}
	}
	return true
}