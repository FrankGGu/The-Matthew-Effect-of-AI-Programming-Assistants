func countRangeSum(nums []int, lower int, upper int) int {
	n := len(nums)
	sums := make([]int64, n+1)
	for i := 1; i <= n; i++ {
		sums[i] = sums[i-1] + int64(nums[i-1])
	}

	return countAndMergeSort(sums, 0, n, lower, upper)
}

func countAndMergeSort(sums []int64, left int, right int, lower int, upper int) int {
	if left >= right {
		return 0
	}

	mid := left + (right-left)/2
	count := countAndMergeSort(sums, left, mid, lower, upper) + countAndMergeSort(sums, mid+1, right, lower, upper)

	i := left
	j := mid + 1
	low := mid + 1
	high := mid + 1

	cache := make([]int64, right-left+1)
	k := 0

	for i <= mid {
		for low <= right && sums[low]-sums[i] < int64(lower) {
			low++
		}
		for high <= right && sums[high]-sums[i] <= int64(upper) {
			high++
		}
		count += high - low

		for j <= right && sums[j] < sums[i] {
			cache[k] = sums[j]
			j++
			k++
		}
		cache[k] = sums[i]
		i++
		k++
	}

	for j <= right {
		cache[k] = sums[j]
		j++
		k++
	}

	copy(sums[left:right+1], cache)

	return count
}