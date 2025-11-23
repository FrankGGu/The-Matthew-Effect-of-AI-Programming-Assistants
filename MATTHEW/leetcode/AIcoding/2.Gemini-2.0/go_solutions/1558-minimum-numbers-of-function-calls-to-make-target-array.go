func minOperations(nums []int) int {
	ans := 0
	maxBit := 0
	for _, num := range nums {
		bit := 0
		tmp := num
		for tmp > 0 {
			bit++
			tmp >>= 1
		}
		maxBit = max(maxBit, bit)
	}

	for i := maxBit - 1; i >= 0; i-- {
		count := 0
		for j := 0; j < len(nums); j++ {
			if nums[j]&1 > 0 {
				count++
				nums[j]--
			}
		}
		ans += count
		allZero := true
		for j := 0; j < len(nums); j++ {
			nums[j] >>= 1
			if nums[j] > 0 {
				allZero = false
			}
		}
		if !allZero {
			ans++
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}