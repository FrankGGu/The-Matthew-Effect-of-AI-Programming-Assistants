package main

func minAdjSwapsForKConsecutive(nums []int, k int) int {
    var indices []int
    for i, num := range nums {
        if num == 1 {
            indices = append(indices, i)
        }
    }

    n := len(indices)
    res := 0
    for i := 0; i < n-k+1; i++ {
        mid := i + (k-1)/2
        for j := i; j <= mid; j++ {
            res += indices[mid] - indices[j]
        }
    }
    return res
}