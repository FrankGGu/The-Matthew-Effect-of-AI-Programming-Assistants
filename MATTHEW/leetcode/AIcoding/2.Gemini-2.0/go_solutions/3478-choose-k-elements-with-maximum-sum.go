func maxKSum(nums []int, k int) int {
	pos, neg, zero := 0, 0, 0
	for _, num := range nums {
		if num > 0 {
			pos++
		} else if num < 0 {
			neg++
		} else {
			zero++
		}
	}

	if k <= pos {
		return k
	}

	if k <= pos+zero {
		return pos
	}

	return pos - (k - pos - zero)
}