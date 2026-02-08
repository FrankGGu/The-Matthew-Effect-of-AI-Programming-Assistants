func findTheNumberOfCopyArrays(nums []int) int {
	const MOD = 1e9 + 7
	n := len(nums)

	prev0 := 1
	prev1 := 1

	for i := 1; i < n; i++ {
		curr0 := 0
		curr1 := 0

		if nums[i-1] <= nums[i] {
			curr0 = (curr0 + prev0) % MOD
		}
		if nums[i-1]+1 <= nums[i] {
			curr0 = (curr0 + prev1) % MOD
		}

		if nums[i-1] <= nums[i]+1 {
			curr1 = (curr1 + prev0) % MOD
		}
		if nums[i-1] <= nums[i] {
			curr1 = (curr1 + prev1) % MOD
		}

		prev0 = curr0
		prev1 = curr1
	}

	return (prev0 + prev1) % MOD
}