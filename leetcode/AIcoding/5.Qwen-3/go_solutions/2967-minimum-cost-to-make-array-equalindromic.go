package main

func minCostToMakeArrayEqualindromic(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    var findMinCost func([]int, int) int
    findMinCost = func(nums []int, targetLen int) int {
        if targetLen == 0 {
            return 0
        }
        res := 0
        for i := 0; i < n; i++ {
            res += abs(nums[i] - nums[n-1-i])
        }
        return res
    }

    minCost := 1<<31 - 1
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            l, r := i, j
            for l <= r {
                if nums[l] != nums[r] {
                    break
                }
                l++
                r--
            }
            if l > r {
                continue
            }
            cost := 0
            for k := 0; k < n; k++ {
                cost += abs(nums[k] - nums[n-1-k])
            }
            if cost < minCost {
                minCost = cost
            }
        }
    }

    return minCost
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}