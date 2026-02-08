import "sort"

func maxConsecutive(coins []int) int {
	sort.Ints(coins)
	res := 1
	for _, coin := range coins {
		if coin <= res {
			res += coin
		} else {
			break
		}
	}
	return res
}