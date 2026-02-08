func nextGreaterElement(nums1 []int, nums2 []int) []int {
    stack := make([]int, 0)
    nextGreater := make(map[int]int)

    for _, num := range nums2 {
        for len(stack) > 0 && stack[len(stack)-1] < num {
            nextGreater[stack[len(stack)-1]] = num
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, num)
    }

    for _, num := range stack {
        nextGreater[num] = -1
    }

    res := make([]int, len(nums1))
    for i, num := range nums1 {
        res[i] = nextGreater[num]
    }

    return res
}