package main

func minOperations(nums []int) int {
    n := len(nums)
    sort.Ints(nums)
    unique := make([]int, 0, n)
    seen := make(map[int]bool)
    for _, num := range nums {
        if !seen[num] {
            seen[num] = true
            unique = append(unique, num)
        }
    }
    m := len(unique)
    res := n
    for i := 0; i < m; i++ {
        target := unique[i]
        j := i
        for j < m && unique[j] <= target+n-1 {
            j++
        }
        res = min(res, n-(j-i))
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}