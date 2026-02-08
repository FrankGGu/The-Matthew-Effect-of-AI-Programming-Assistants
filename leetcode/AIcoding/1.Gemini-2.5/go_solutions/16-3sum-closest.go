import (
	"sort"
)

func threeSumClosest(nums []int, target int) int {
	sort.Ints(nums)
	n := len(nums)
	closestSum := nums[0] + nums[1] + nums[2]

	for i := 0; i < n-2; i++ {
		left := i + 1
		right := n - 1

		for left < right {
			currentSum := nums[i] + nums[left] + nums[right]

			if currentSum == target {
				return target
			}

			if absInt(currentSum-target) < absInt(closestSum-target) {
				closestSum = currentSum
			}

			if currentSum < target {
				left++
			} else {
				right--
			}
		}
	}
	return closestSum
}

func absInt(x int) int {
	if x < 0 {
		return -x
	}
	return x
}