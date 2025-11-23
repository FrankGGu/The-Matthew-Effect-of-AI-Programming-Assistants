import "sort"

func sortJumbled(mapping []int, nums []int) []int {
	type JumbledNum struct {
		original int
		jumbled  int
		index    int
	}

	jumbledNums := make([]JumbledNum, len(nums))

	for i, num := range nums