package main

func minSwapsCouples(nums []int) int {
    pos := make([]int, len(nums))
    for i := 0; i < len(nums); i++ {
        pos[nums[i]] = i
    }

    swaps := 0
    for i := 0; i < len(nums); i += 2 {
        a := nums[i]
        b := a ^ 1
        if nums[i+1] == b {
            continue
        }
        j := pos[b]
        pos[nums[i+1]] = j
        pos[b] = i + 1
        nums[i+1], nums[j] = nums[j], nums[i+1]
        swaps++
    }
    return swaps
}