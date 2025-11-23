func canReorderDoubled(arr []int) bool {
	count := make(map[int]int)
	for _, num := range arr {
		count[num]++
	}

	abs := func(x int) int {
		if x < 0 {
			return -x
		}
		return x
	}

	nums := make([]int, 0, len(arr))
	for num := range count {
		nums = append(nums, num)
	}

	sortFunc := func(i, j int) bool {
		return abs(nums[i]) < abs(nums[j])
	}

	sort(nums, sortFunc)

	for _, num := range nums {
		if count[num] == 0 {
			continue
		}

		target := 2 * num
		if count[target] == 0 {
			return false
		}

		if count[num] > count[target] {
			return false
		}

		count[target] -= count[num]
	}

	return true
}

func sort(data []int, less func(i, j int) bool) {
	for i := 0; i < len(data); i++ {
		for j := i + 1; j < len(data); j++ {
			if less(j, i) {
				data[i], data[j] = data[j], data[i]
			}
		}
	}
}