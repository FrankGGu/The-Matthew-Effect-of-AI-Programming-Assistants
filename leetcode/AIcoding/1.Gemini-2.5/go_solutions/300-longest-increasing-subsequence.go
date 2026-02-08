import "sort"

func lengthOfLIS(nums []int) int {
	tails := []int{}
	for _, num := range nums {
		i := sort.SearchInts(tails, num)
		if i == len(tails) {
			tails = append(tails, num)
		} else {
			tails[i] = num
		}
	}
	return len(tails)
}