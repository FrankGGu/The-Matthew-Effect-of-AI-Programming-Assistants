package main

func semiOrderedPermutation(nums []int) int {
    n := len(nums)
    pos := make(map[int]int)
    for i, num := range nums {
        pos[num] = i
    }
    res := 0
    for i := 1; i < n; i++ {
        if nums[i] == i+1 {
            continue
        }
        j := pos[i+1]
        if j > i {
            nums[i], nums[j] = nums[j], nums[i]
            pos[nums[i]] = i
            pos[nums[j]] = j
            res++
        } else {
            nums[i], nums[j] = nums[j], nums[i]
            pos[nums[i]] = i
            pos[nums[j]] = j
            res++
        }
    }
    return res
}