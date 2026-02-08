func judgeSquareSum(c int) bool {
	left := 0
	right := int(math.Sqrt(float64(c)))

	for left <= right {
		sumSq := left*left + right*right
		if sumSq == c {
			return true
		} else if sumSq < c {
			left++
		} else {
			right--
		}
	}
	return false
}