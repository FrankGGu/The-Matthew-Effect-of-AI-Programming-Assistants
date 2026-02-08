func distributeElements(nums []int, k int) []int {
	n := len(nums)
	arr1 := make([]int, 0)
	arr2 := make([]int, 0)
	idx1 := 0
	idx2 := 0
	for i := 0; i < n; i++ {
		if idx1 == 0 || nums[i] >= arr1[idx1-1] {
			arr1 = append(arr1, nums[i])
			idx1++
		} else if idx2 == 0 || nums[i] >= arr2[idx2-1] {
			arr2 = append(arr2, nums[i])
			idx2++
		} else if idx1 <= k {
			arr1 = append(arr1, nums[i])
			idx1++
		} else if idx2 <= k {
			arr2 = append(arr2, nums[i])
			idx2++
		} else {
			if arr1[idx1-1] <= arr2[idx2-1] {
				arr1 = append(arr1, nums[i])
				idx1++
			} else {
				arr2 = append(arr2, nums[i])
				idx2++
			}
		}
	}
	return append(arr1, arr2...)
}