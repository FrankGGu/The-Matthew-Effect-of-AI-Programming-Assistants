package main

func maxXORSubarrayQueries(nums []int, queries [][]int) []int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] ^ nums[i]
    }
    res := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        res[i] = prefix[r+1] ^ prefix[l]
    }
    return res
}