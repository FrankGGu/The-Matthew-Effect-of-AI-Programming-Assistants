func canSortArray(nums []int) bool {
	n := len(nums)
	if n <= 1 {
		return true
	}

	i := 0
	for i < n-1 {
		j := i + 1
		power := bits(nums[i])
		for j < n && bits(nums[j]) == power {
			j++
		}

		sub := nums[i:j]
		sortedSub := make([]int, len(sub))
		copy(sortedSub, sub)
		sort(sortedSub)

		for k := 0; k < len(sub); k++ {
			nums[i+k] = sortedSub[k]
		}

		i = j
	}

	for i := 0; i < n-1; i++ {
		if nums[i] > nums[i+1] {
			return false
		}
	}

	return true
}

func bits(x int) int {
	count := 0
	for x > 0 {
		x &= (x - 1)
		count++
	}
	return count
}

func sort(arr []int) {
	for i := 0; i < len(arr); i++ {
		for j := i + 1; j < len(arr); j++ {
			if arr[i] > arr[j] {
				arr[i], arr[j] = arr[j], arr[i]
			}
		}
	}
}