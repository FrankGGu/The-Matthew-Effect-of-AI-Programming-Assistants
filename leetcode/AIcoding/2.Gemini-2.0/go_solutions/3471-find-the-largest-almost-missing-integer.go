import "sort"

func largestAlmostMissing(nums []int, m int) int {
	sort.Ints(nums)
	n := len(nums)
	missing := 0
	for i := 1; ; i++ {
		found := false
		for j := 0; j < n; j++ {
			if nums[j] == i {
				found = true
				break
			}
		}
		if !found {
			missing++
			if missing > m {
				return i
			}
		}
		if i > 200 {
			return i
		}
	}
}