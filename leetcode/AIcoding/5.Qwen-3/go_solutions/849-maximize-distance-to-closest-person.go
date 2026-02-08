package main

func maxDistToClosest(nums []int) int {
    n := len(nums)
    maxDist := 0
    prev := -1

    for i := 0; i < n; i++ {
        if nums[i] == 1 {
            if prev != -1 {
                dist := i - prev
                if dist > maxDist {
                    maxDist = dist
                }
            } else {
                maxDist = i
            }
            prev = i
        }
    }

    if prev != n-1 {
        maxDist = max(maxDist, n-1-prev)
    }

    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}