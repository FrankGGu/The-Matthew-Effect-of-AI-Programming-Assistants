package main

import (
    "fmt"
)

func findSubsequences(nums []int) [][]int {
    res := [][]int{}
    var backtrack func(start int, path []int)
    backtrack = func(start int, path []int) {
        if len(path) > 1 {
            res = append(res, append([]int{}, path...))
        }
        used := make(map[int]bool)
        for i := start; i < len(nums); i++ {
            if (len(path) == 0 || nums[i] >= path[len(path)-1]) && !used[nums[i]] {
                used[nums[i]] = true
                backtrack(i+1, append(path, nums[i]))
            }
        }
    }
    backtrack(0, []int{})
    return res
}

func main() {
    nums := []int{4, 6, 7, 7}
    result := findSubsequences(nums)
    fmt.Println(result)
}