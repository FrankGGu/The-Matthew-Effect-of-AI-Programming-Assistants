func createTargetArray(nums []int, index []int) []int {
	target := []int{}
	for i := 0; i < len(nums); i++ {
		val := nums[i]
		idx := index[i]

		if idx == len(target) {
			target = append(target, val)
		} else {
			target = append(target[:idx], append([]int{val}, target[idx:]...)...)
		}
	}
	return target
}