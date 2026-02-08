func arraySign(nums []int) int {
	negCount := 0
	for _, num := range nums {
		if num == 0 {
			return 0
		}
		if num < 0 {
			negCount++
		}
	}

	if negCount%2 == 0 {
		return 1
	} else {
		return -1
	}
}