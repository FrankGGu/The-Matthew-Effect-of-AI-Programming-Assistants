func numberOfPairs(nums []int) int {
	count := 0
	seen := make(map[int]bool)
	for _, num := range nums {
		if _, ok := seen[num]; !ok {
			seen[num] = true
			for i := 0; i < len(nums); i++ {
				if i != index(nums, num) && nums[i] == num {
					count++
					nums[index(nums, num)] = -1
					nums[i] = -1
					break
				}
			}
		}
	}

	unpaired := 0
	for _, num := range nums {
		if num != -1 {
			unpaired++
		}
	}
	return count
}

func index(nums []int, target int) int {
	for i, num := range nums {
		if num == target {
			return i
		}
	}
	return -1
}