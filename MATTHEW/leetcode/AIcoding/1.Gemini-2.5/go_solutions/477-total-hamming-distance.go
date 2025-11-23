func totalHammingDistance(nums []int) int {
	n := len(nums)
	totalDistance := 0

	for i := 0; i < 32; i++ {
		count0 := 0
		count1 := 0
		for j := 0; j < n; j++ {
			if (nums[j]>>i)&1 == 0 {
				count0++
			} else {
				count1++
			}
		}
		totalDistance += count0 * count1
	}

	return totalDistance
}