func nextGreaterElement(nums1 []int, nums2 []int) []int {
    nextGreater := make(map[int]int)
    stack := []int{}

    for _, num := range nums2 {
        for len(stack) > 0 && stack[len(stack)-1] < num {
            nextGreater[stack[len(stack)-1]] = num
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, num)
    }

    result := make([]int, len(nums1))
    for i, num := range nums1 {
        if val, found := nextGreater[num]; found {
            result[i] = val
        } else {
            result[i] = -1
        }
    }

    return result
}