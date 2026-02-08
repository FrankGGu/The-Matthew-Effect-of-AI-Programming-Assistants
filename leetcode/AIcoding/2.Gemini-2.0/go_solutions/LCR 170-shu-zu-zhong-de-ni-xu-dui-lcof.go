func reversePairs(nums []int) int {
	n := len(nums)
	if n <= 1 {
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

	i := left
	j := mid + 1
	k := 0

	for i <= mid && j <= right {
		if nums[i] <= nums[j] {
			temp[k] = nums[i]
			i++
		} else {
			temp[k] = nums[j]
			j++
			count += mid - i + 1
		}
		k++
	}

	for i <= mid {
		temp[k] = nums[i]
		i++
		k++
	}

	for j <= right {
		temp[k] = nums[j]
		j++
		k++
	}

	for i := 0; i < k; i++ {
		nums[left+i] = temp[i]
	}

	return count
}