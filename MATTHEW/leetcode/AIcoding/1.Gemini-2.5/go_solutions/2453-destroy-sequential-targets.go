import "math"

func destroyTargets(nums []int, space int) int {
	counts := make(map[int]int)
	minNumsForRemainder := make(map[int]int)

	for _, num := range nums {
		remainder := num % space
		counts[remainder]++
		if _, ok := minNumsForRemainder[remainder]; !ok {
			minNumsForRemainder[remainder] = num
		} else {
			if num < minNumsForRemainder[remainder] {
				minNumsForRemainder[remainder] = num
			}
		}
	}

	maxCount := 0
	minStartNum := math.MaxInt32

	for remainder, count := range counts {
		if count > maxCount {
			maxCount = count
			minStartNum = minNumsForRemainder[remainder]
		} else if count == maxCount {
			if minNumsForRemainder[remainder] < minStartNum {
				minStartNum = minNumsForRemainder[remainder]
			}
		}
	}

	return minStartNum
}