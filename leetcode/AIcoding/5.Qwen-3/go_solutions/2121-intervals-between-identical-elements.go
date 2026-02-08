package main

func elementInterval(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    lastPos := make(map[int]int)

    for i := 0; i < n; i++ {
        if pos, ok := lastPos[nums[i]]; ok {
            res[i] = i - pos
        } else {
            res[i] = -1
        }
        lastPos[nums[i]] = i
    }

    return res
}