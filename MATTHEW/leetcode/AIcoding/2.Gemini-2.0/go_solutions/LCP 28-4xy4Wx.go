import "sort"

func purchasePlans(nums []int, target int) int {
	sort.Ints(nums)
	left, right := 0, len(nums)-1
	count := 0
	for left < right {
		if nums[left]+nums[right] <= target {
			count = (count + (right - left)) % 1000000007
			left++
		} else {
			right--
		}
	}
	return count
}