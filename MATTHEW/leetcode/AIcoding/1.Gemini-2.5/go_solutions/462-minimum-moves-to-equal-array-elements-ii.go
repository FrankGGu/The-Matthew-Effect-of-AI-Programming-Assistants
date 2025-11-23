import "sort"

func minMoves2(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	median := nums[n/2]
	moves := 0
	for _, num := range nums {
		diff := num - median
		if diff < 0 {
			moves -= diff
		} else {
			moves += diff
		}
	}
	return moves
}