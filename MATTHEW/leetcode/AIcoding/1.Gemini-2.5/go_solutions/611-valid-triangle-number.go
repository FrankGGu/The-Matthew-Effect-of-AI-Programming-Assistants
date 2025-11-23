import (
	"sort"
)

func triangleNumber(nums []int) int {
	n := len(nums)
	if n < 3 {
		return 0
	}

	sort.Ints(nums)

	count := 0
	for k := n - 1; k >= 2; k-- {
		i := 0
		j := k - 1
		for i < j {
			if nums[i]+nums[j] > nums[k] {
				count += (j - i)
				j--
			} else {
				i++
			}
		}
	}

	return count
}