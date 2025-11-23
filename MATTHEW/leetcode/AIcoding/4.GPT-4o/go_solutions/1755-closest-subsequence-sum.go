package main

import (
    "fmt"
    "math"
    "sort"
)

func closestSubsequenceSum(nums []int, goal int) int {
    n := len(nums)
    sumSet := make(map[int]struct{})
    sumSet[0] = struct{}{}

    for _, num := range nums {
        newSums := make(map[int]struct{})
        for s := range sumSet {
            newSums[s+num] = struct{}{}
            newSums[s] = struct{}{}
        }
        sumSet = newSums
    }

    closest := math.MaxInt32
    for s := range sumSet {
        if abs(s-goal) < abs(closest-goal) {
            closest = s
        }
    }

    return closest
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    nums := []int{5, -7, 3, 5}
    goal := 6
    fmt.Println(closestSubsequenceSum(nums, goal))
}