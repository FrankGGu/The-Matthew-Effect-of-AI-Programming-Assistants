func sumOfThree(num int64) []int64 {
	if num%3 == 0 {
		x := num / 3
		return []int64{x - 1, x, x + 1}
	}
	return []int64{}
}