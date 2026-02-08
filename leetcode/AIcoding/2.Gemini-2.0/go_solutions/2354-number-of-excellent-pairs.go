func countExcellentPairs(nums []int, k int) int64 {
	count := make([]int, 32)
	seen := make(map[int]bool)
	for _, num := range nums {
		if !seen[num] {
			seen[num] = true
			bits := 0
			for num > 0 {
				bits += num & 1
				num >>= 1
			}
			count[bits]++
		}
	}

	var result int64
	for i := 1; i < 32; i++ {
		if count[i] > 0 {
			for j := 1; j < 32; j++ {
				if count[j] > 0 {
					if i+j >= k {
						result += int64(count[i]) * int64(count[j])
					}
				}
			}
		}
	}

	return result
}