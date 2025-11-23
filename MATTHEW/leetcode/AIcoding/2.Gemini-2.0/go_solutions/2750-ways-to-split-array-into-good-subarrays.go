func numberOfGoodSubarraySplits(nums []int) int {
	first := -1
	last := -1
	n := len(nums)
	for i := 0; i < n; i++ {
		if nums[i] == 1 {
			if first == -1 {
				first = i
			}
			last = i
		}
	}

	if first == -1 {
		return 0
	}

	ans := 1
	mod := 1000000007
	count := 0
	for i := first + 1; i <= last; i++ {
		if nums[i] == 0 {
			count++
		} else {
			ans = (ans * (count + 1)) % mod
			count = 0
		}
	}

	return ans
}