func incremovableSubarrayCount(nums []int) int {
	n := len(nums)
	count := 0

	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			temp := []int{}
			for k := 0; k < n; k++ {
				if k < i || k > j {
					temp = append(temp, nums[k])
				}
			}

			if len(temp) == 0 {
				count++
				continue
			}

			sorted := true
			for k := 1; k < len(temp); k++ {
				if temp[k] <= temp[k-1] {
					sorted = false;
					break
				}
			}

			if sorted {
				count++
			}
		}
	}

	return count
}