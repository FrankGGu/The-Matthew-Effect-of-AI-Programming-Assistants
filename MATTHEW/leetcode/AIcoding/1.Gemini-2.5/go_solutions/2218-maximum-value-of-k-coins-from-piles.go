import "math"

func maxValueOfCoins(piles [][]int, k int) int {
	dp := make([]int, k+1)

	for _, pile := range piles {
		prefixSum := make([]int, len(pile)+1)
		for i := 0; i < len(pile);