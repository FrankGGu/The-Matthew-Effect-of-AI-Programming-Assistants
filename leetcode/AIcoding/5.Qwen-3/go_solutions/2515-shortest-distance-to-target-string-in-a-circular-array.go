package main

func closetTarget(nums []int, target int, start int) int {
    n := len(nums)
    minDistance := n
    for i := 0; i < n; i++ {
        if nums[i] == target {
            distance := min(abs(i - start), n-abs(i - start))
            if distance < minDistance {
                minDistance = distance
            }
        }
    }
    return minDistance
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}