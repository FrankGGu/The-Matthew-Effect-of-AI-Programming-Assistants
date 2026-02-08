package main

func minDistance(nums []int, target int, start int) int {
    minDist := len(nums)
    for i, num := range nums {
        if num == target {
            dist := abs(i - start)
            if dist < minDist {
                minDist = dist
            }
        }
    }
    return minDist
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}