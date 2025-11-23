func minDeletions(nums []int) int {
	stack := []int{}
	deletions := 0

	for _, num := range nums {
		if len(stack)%2 == 0 {
			stack = append(stack, num)
		} else {
			if num != stack[len(stack)-1] {
				stack = append(stack, num)
			} else {
				deletions++
			}
		}
	}

	if len(stack)%2 == 1 {
		deletions++
	}

	return deletions
}