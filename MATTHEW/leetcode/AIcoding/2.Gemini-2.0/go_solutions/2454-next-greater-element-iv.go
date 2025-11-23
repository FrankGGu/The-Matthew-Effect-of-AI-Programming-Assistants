func nextGreaterElements(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }
    stack1 := []int{}
    stack2 := []int{}

    for i := 0; i < n; i++ {
        for len(stack2) > 0 && nums[stack2[len(stack2)-1]] < nums[i] {
            res[stack2[len(stack2)-1]] = nums[i]
            stack2 = stack2[:len(stack2)-1]
        }

        tempStack := []int{}
        for len(stack1) > 0 && nums[stack1[len(stack1)-1]] < nums[i] {
            tempStack = append(tempStack, stack1[len(stack1)-1])
            stack1 = stack1[:len(stack1)-1]
        }

        for len(tempStack) > 0 {
            stack2 = append(stack2, tempStack[len(tempStack)-1])
            tempStack = tempStack[:len(tempStack)-1]
        }

        stack1 = append(stack1, i)
    }

    return res
}