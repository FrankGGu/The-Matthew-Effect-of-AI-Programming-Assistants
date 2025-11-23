import "sort"

func distinctAverages(nums []int) int {
	sort.Ints(nums)
	seen := make(map[float64]bool)
	i, j := 0, len(nums)-1
	for i < j {
		avg := float64(nums[i]+nums[j]) / 2.0
		seen[avg] = true
		i++
		j--
	}
	return len(seen)
}