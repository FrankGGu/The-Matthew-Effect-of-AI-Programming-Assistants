package main

func kEmptySlots(nums []int, k int) int {
    n := len(nums)
    pos := make([]int, n+2)
    for i := 0; i < n; i++ {
        pos[nums[i]] = i + 1
    }

    res := -1
    left, right := 1, n
    for left < right {
        if pos[left] < pos[right] {
            if right-left-1 == k {
                res = pos[left]
            }
            left++
        } else {
            if right-left-1 == k {
                res = pos[right]
            }
            right--
        }
    }
    return res
}