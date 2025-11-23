func reversePairs(nums []int) int {
	n := len(nums)
	if n < 2 {
		return 0
	}

	temp := make([]int, n)
	return mergeSort(nums, 0, n-1, temp)
}

func mergeSort(nums []int, left, right int, temp []int) int {
	if left >= right {
		return 0
	}

	mid := left + (right-left)/2
	count := mergeSort(nums, left, mid, temp) + mergeSort(nums, mid+1, right, temp)

	i, j, pos := left, mid+1, left
	for i <= mid && j <= right {
		if nums[i] <= nums[j] {
			temp[pos] = nums[i]
			i++
		} else {
			temp[pos] = nums[j]
			j++
			count += mid - i + 1
		}
		pos++
	}

	for i <= mid {
		temp[pos] = nums[i]
		i++
		pos++
	}
	for j <= right {
		temp[pos] = nums[j]
		j++
		pos++
	}

	for i := left; i <= right; i++ {
		nums[i] = temp[i]
	}

	return count
}