import "sort"

func maxConsecutive(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 1
	for i := 0; i < n; i++ {
		curr := 1
		last := nums[i]
		for j := i + 1; j < n; j++ {
			if nums[j] == last {
				continue
			} else if nums[j] == last+1 {
				curr++
				last = nums[j]
			} else if nums[j] == last+2 {
				curr++
				last = nums[j] - 1
			} else if nums[j] > last+2 {
				break
			}
		}
		ans = max(ans, curr)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}