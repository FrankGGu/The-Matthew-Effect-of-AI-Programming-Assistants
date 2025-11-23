func numberOfPairs(nums1 []int, nums2 []int, diff int) int64 {
	n := len(nums1)
	nums := make([]int, n)
	for i := 0; i < n; i++ {
		nums[i] = nums1[i] - nums2[i]
	}

	var mergeSort func([]int) int64
	mergeSort = func(arr []int) int64 {
		if len(arr) <= 1 {
			return 0
		}

		mid := len(arr) / 2
		left := arr[:mid]
		right := arr[mid:]

		count := mergeSort(left) + mergeSort(right)

		i, j := 0, 0
		for i < len(left) {
			for j < len(right) && left[i] > right[j]+diff {
				j++
			}
			count += int64(len(right) - j)
			i++
		}

		i, j = 0, 0
		k := 0
		temp := make([]int, len(arr))
		for i < len(left) && j < len(right) {
			if left[i] <= right[j] {
				temp[k] = left[i]
				i++
			} else {
				temp[k] = right[j]
				j++
			}
			k++
		}

		for i < len(left) {
			temp[k] = left[i]
			i++
			k++
		}

		for j < len(right) {
			temp[k] = right[j]
			j++
			k++
		}

		copy(arr, temp)
		return count
	}

	return mergeSort(nums)
}