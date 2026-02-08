func countInversions(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	temp := make([]int, n)
	return mergeSortAndCount(nums, temp, 0, n-1)
}

func mergeSortAndCount(nums []int, temp []int, left int, right int) int {
	count := 0
	if left < right {
		mid := (left + right) / 2
		count += mergeSortAndCount(nums, temp, left, mid)
		count += mergeSortAndCount(nums, temp, mid+1, right)
		count += mergeAndCount(nums, temp, left, mid, right)
	}
	return count
}

func mergeAndCount(nums []int, temp []int, left int, mid int, right int) int {
	i := left
	j := mid + 1
	k := left
	count := 0

	for i <= mid && j <= right {
		if nums[i] <= nums[j] {
			temp[k] = nums[i]
			i++
			k++
		} else {
			temp[k] = nums[j]
			j++
			k++
			count += (mid - i + 1)
		}
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

	for i := left; i <= right; i++ {
		nums[i] = temp[i]
	}

	return count
}