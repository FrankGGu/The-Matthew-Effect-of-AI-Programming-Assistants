package main

import "sort"

func maximumXORScore(nums []int, queries []int) []int {
    n := len(nums)
    prefixXor := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixXor[i+1] = prefixXor[i] ^ nums[i]
    }

    results := make([]int, len(queries))
    queryIndices := make([]int, len(queries))
    for i := range queries {
        queryIndices[i] = i
    }

    sort.Slice(queryIndices, func(i, j int) bool {
        return queries[queryIndices[i]] < queries[queryIndices[j]]
    })

    maxXor := 0
    j := 0
    for _, idx := range queryIndices {
        queryValue := queries[idx]
        for j < n && prefixXor[j] <= queryValue {
            if j > 0 {
                maxXor = max(maxXor, prefixXor[j])
            }
            j++
        }
        results[idx] = maxXor
    }

    return results
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}