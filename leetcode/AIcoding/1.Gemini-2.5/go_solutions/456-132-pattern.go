package solution

import "math"

func find132pattern(nums []int) bool {
    n := len(nums)
    if n < 3 {
        return false
    }

    // s2 will store the '2' in the '132' pattern.
    // It represents the largest number found so far that is smaller than some '3' (from the stack).
    s2 := math.MinInt32 

    // stack will store potential '3's in the '132' pattern.
    // Elements are pushed onto the stack as we iterate from right to left.
    // When we encounter a number (nums[i]) that is greater than the top of the stack,
    // that stack top element becomes a candidate for '2' (s2) because it's less than nums[i] (a potential '3').
    stack := []int{} 

    // Iterate from right to left.
    // nums[i] will be the potential '1' in the '132' pattern.
    for i := n - 1; i >= 0; i-- {
        // If nums[i] is smaller than s2, we have found a '132' pattern.
        // nums[i] is '1', s2 is '2', and some element previously popped from the stack was '3'.
        if nums[i] < s2 {
            return true
        }

        // While the stack is not empty and the current nums[i] is greater than the top of the stack:
        // This means stack.peek() could be a potential '2' because it's smaller than nums[i].
        // We want to find the largest possible '2' that is less than a '3' (which would be nums[i] or some larger element popped earlier).
        // So, we update s2 with the popped element and remove it from the stack.
        // The elements remaining on the stack are candidates for '3' that are greater than the current nums[i].
        for len(stack) > 0 && nums[i] > stack[len(stack)-1] {
            s2 = stack[len(stack)-1] // This popped element is a candidate for '2'
            stack = stack[:len(stack)-1] // Pop from stack
        }

        // Push nums[i] onto the stack. This nums[i] is now a potential '3'
        // for elements to its left (smaller indices).
        stack = append(stack, nums[i])
    }

    // If the loop finishes, no '132' pattern was found.
    return false
}