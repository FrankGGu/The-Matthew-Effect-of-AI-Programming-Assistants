func countBalls(lowLimit int, highLimit int) int {
	count := make(map[int]int)
	maxCount := 0

	for i := lowLimit; i <= highLimit; i++ {
		sum := 0
		num := i
		for num > 0 {
			sum += num % 10
			num /= 10
		}
		count[sum]++
		if count[sum] > maxCount {
			maxCount = count[sum]
		}
	}

	return maxCount
}