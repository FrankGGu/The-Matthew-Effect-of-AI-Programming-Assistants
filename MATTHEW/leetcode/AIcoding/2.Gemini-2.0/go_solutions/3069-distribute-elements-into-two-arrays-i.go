func distributeElements(nums []int) []int {
	arr1 := make([]int, 0)
	arr2 := make([]int, 0)
	for _, num := range nums {
		if len(arr1) == 0 || num >= arr1[len(arr1)-1] {
			arr1 = append(arr1, num)
		} else {
			arr2 = append(arr2, num)
		}
	}
	return append(arr1, arr2...)
}