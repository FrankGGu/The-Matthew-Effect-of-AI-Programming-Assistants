package main

func rob(nums []int) int {
    if len(nums) == 1 {
        return nums[0]
    }
    if len(nums) == 2 {
        if nums[0] > nums[1] {
            return nums[0]
        }
        return nums[1]
    }
    return max(robHelper(nums[0:len(nums)-1]), robHelper(nums[1:len(nums)]))
}

func robHelper(nums []int) int {
    prev, curr := 0, 0
    for _, num := range nums {
        temp := curr
        curr = max(prev+num, curr)
        prev = temp
    }
    return curr
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}