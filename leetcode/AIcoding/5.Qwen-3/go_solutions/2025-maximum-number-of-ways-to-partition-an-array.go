package main

func maxNumberofWays(arr []int, k int) int {
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + arr[i]
    }

    count := make(map[int]int)
    res := 0

    for i := 1; i <= n; i++ {
        target := k - prefix[i]
        res += count[target]
        count[prefix[i]]++
    }

    return res
}