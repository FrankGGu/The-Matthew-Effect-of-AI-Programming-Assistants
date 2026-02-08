package main

func maxSlidingWindow(nums []int, k int) []int {
    if len(nums) == 0 || k == 0 {
        return []int{}
    }

    result := make([]int, 0)
    deque := make([]int, 0)

    for i := 0; i < len(nums); i++ {
        // Remove elements smaller than the current element from the deque
        for len(deque) > 0 && nums[i] >= nums[deque[len(deque)-1]] {
            deque = deque[:len(deque)-1]
        }

        deque = append(deque, i)

        // Remove the elements out of the current window
        if deque[0] <= i - k {
            deque = deque[1:]
        }

        // Add the maximum element in the current window to the result
        if i >= k - 1 {
            result = append(result, nums[deque[0]])
        }
    }

    return result
}