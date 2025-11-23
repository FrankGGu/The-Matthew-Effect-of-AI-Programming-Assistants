func numberOfSubarrays(nums []int, k int) int {
	count := 0
	oddCounts := make([]int, 0)
	oddCounts = append(oddCounts, -1)
	for i := 0; i < len(nums); i++ {
		if nums[i]%2 != 0 {
			oddCounts = append(oddCounts, i)
		}
	}
	oddCounts = append(oddCounts, len(nums))

	for i := 1; i < len(oddCounts)-k; i++ {
		count += (oddCounts[i] - oddCounts[i-1]) * (oddCounts[i+k] - oddCounts[i+k-1])
	}

	return count
}