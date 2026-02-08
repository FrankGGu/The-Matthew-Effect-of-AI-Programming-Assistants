package main

func minOrAfterOperationsToZero(nums []int) int {
    n := len(nums)
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            return 0
        }
    }

    var mask int
    for i := 0; i < 30; i++ {
        cnt := 0
        for _, num := range nums {
            if (num & mask) != 0 {
                cnt++
            }
        }
        if cnt == 0 {
            continue
        }
        if cnt == 1 {
            mask |= 1 << i
        } else {
            mask &= ^(1 << i)
        }
    }

    for i := 0; i < n; i++ {
        nums[i] &= mask
    }

    res := 0
    for _, num := range nums {
        res |= num
    }
    return res
}