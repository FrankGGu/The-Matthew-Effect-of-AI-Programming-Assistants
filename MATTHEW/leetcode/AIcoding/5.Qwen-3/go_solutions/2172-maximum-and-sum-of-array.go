package main

func maxAndSum(nums []int, numSlots int) int {
    memo := make(map[int]int)
    var dp func(int) int
    dp = func(mask int) int {
        if mask == 0 {
            return 0
        }
        if val, ok := memo[mask]; ok {
            return val
        }
        maxVal := 0
        for i := 0; i < numSlots; i++ {
            if (mask >> (i * 2)) & 3 != 0 {
                continue
            }
            for j := 0; j < len(nums); j++ {
                if (mask >> (j * 2)) & 3 == 0 {
                    newMask := mask
                    newMask |= (1 << (j * 2))
                    newMask |= (1 << (i * 2 + 1))
                    currentAnd := nums[j] & nums[i]
                    res := currentAnd + dp(newMask)
                    if res > maxVal {
                        maxVal = res
                    }
                }
            }
        }
        memo[mask] = maxVal
        return maxVal
    }
    return dp((1 << (len(nums) * 2)) - 1)
}