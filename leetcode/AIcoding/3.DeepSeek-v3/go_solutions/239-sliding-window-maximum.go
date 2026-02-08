func maxSlidingWindow(nums []int, k int) []int {
    if len(nums) == 0 {
        return []int{}
    }

    var queue []int
    var result []int

    for i := 0; i < len(nums); i++ {
        for len(queue) > 0 && queue[0] < i - k + 1 {
            queue = queue[1:]
        }

        for len(queue) > 0 && nums[queue[len(queue)-1]] < nums[i] {
            queue = queue[:len(queue)-1]
        }

        queue = append(queue, i)

        if i >= k - 1 {
            result = append(result, nums[queue[0]])
        }
    }

    return result
}