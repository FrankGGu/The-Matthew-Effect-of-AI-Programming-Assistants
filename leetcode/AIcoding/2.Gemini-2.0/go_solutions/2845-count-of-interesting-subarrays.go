func countInterestingSubarrays(nums []int, modulo int, k int) int64 {
	n := len(nums)
	prefix := make([]int, n+1)
	for i := 1; i <= n; i++ {
		prefix[i] = prefix[i-1] + (nums[i-1]%modulo == k%modulo ? 1 : 0)
	}

	count := int64(0)
	freq := make(map[int]int)
	freq[0] = 1

	for i := 1; i <= n; i++ {
		rem := prefix[i] % modulo
		target := (rem - k%modulo + modulo) % modulo
		count += int64(freq[target])
		freq[rem]++
	}

	return count
}