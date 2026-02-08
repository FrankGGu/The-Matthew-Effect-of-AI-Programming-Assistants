func distributeElements(nums []int) []int {
	arr1 := []int{nums[0]}
	arr2 := []int{nums[1]}

	for i := 2; i < len(nums); i++ {
		if arr1[len(arr1)-1] > arr2[len(arr2)-1] {
			arr1 = append(arr1, nums[i])
		} else {
			arr2 = append(arr2, nums[i])
		}
	}

	result := make([]int, 0, len(nums))
	result = append(result, arr1...)
	result = append(result, arr2...)

	return result
}