package main

func findThePowerOfKSubarrays(nums []int, k int) []int64 {
	n := len(nums)
	if n == 0 || k == 0 || k > n {
		return []int64{}
	}

	result := make([]int64, 0, n-k+1)

	var currentPower int64
	var currentWindowSum int64

	for i := 0; i < k; i++ {
		currentPower += int64(nums[i]) * int64(i+1)
		currentWindowSum += int64(nums[i])
	}
	result = append(result, currentPower)

	for i := 1; i <= n-k; i++ {
		currentPower = (currentPower - currentWindowSum) + int64(nums[i+k-1])*int64(k)
		currentWindowSum = currentWindowSum - int64(nums[i-1]) + int64(nums[i+k-1])
		result = append(result, currentPower)
	}

	return result
}