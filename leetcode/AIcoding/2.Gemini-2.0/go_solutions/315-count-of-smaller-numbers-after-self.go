func countSmaller(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	indexedNums := make([][]int, n)
	for i := range nums {
		indexedNums[i] = []int{nums[i], i}
	}
	temp := make([][]int, n)
	var mergeSort func(int, int)
	mergeSort = func(left, right int) {
		if left >= right {
			return
		}
		mid := left + (right-left)/2
		mergeSort(left, mid)
		mergeSort(mid+1, right)
		i, j, k := left, mid+1, left
		smaller := 0
		for i <= mid && j <= right {
			if indexedNums[i][0] > indexedNums[j][0] {
				smaller++
				temp[k] = indexedNums[j]
				j++
			} else {
				result[indexedNums[i][1]] += smaller
				temp[k] = indexedNums[i]
				i++
			}
			k++
		}
		for i <= mid {
			result[indexedNums[i][1]] += smaller
			temp[k] = indexedNums[i]
			i++
			k++
		}
		for j <= right {
			temp[k] = indexedNums[j]
			j++
			k++
		}
		for i := left; i <= right; i++ {
			indexedNums[i] = temp[i]
		}
	}
	mergeSort(0, n-1)
	return result
}