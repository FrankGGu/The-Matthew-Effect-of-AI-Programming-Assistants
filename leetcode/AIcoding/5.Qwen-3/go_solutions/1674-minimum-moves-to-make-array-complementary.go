package main

func minMoves(nums []int, limit int) int {
    n := len(nums)
    diff := make([]int, 2*limit+2)

    for i := 0; i < n/2; i++ {
        a, b := nums[i], nums[n-1-i]
        minVal := a + b
        maxVal := a + b

        for j := 0; j <= limit; j++ {
            if j != a && j != b {
                if j < minVal {
                    diff[j]++
                } else if j > maxVal {
                    diff[j]++
                }
            }
        }

        diff[minVal]--
        diff[maxVal+1]++
    }

    res := 0
    current := 0
    for i := 0; i <= 2*limit; i++ {
        current += diff[i]
        res = min(res, current)
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}