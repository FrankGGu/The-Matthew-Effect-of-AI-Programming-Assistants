package main

func minSubarray(nums []int, p int) int {
    n := len(nums)
    modSum := 0
    for _, num := range nums {
        modSum = (modSum + num) % p
    }
    if modSum == 0 {
        return 0
    }

    prefixMod := make(map[int]int)
    prefixMod[0] = -1
    currentMod := 0
    result := n

    for i, num := range nums {
        currentMod = (currentMod + num) % p
        targetMod := (currentMod - modSum + p) % p
        if idx, ok := prefixMod[targetMod]; ok {
            result = min(result, i-idx)
        }
        prefixMod[currentMod] = i
    }

    if result == n {
        return -1
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}