import "sort"

func specialArray(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	for x := 1; x <= n; x++ {
		count := 0
		for _, num := range nums {
			if num >= x {
				count++
			}
		}
		if count == x {
			return x
		}
	}
	return -1
}