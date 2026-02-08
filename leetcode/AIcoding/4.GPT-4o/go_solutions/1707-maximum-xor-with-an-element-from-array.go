package main

import "sort"

func maximizeXor(arr []int, maximumBit int) []int {
    sort.Ints(arr)
    result := make([]int, len(arr))
    prefix := 0
    for i := 0; i < len(arr); i++ {
        if i > 0 && arr[i] != arr[i-1] {
            prefix = arr[i-1]
        }
        result[i] = prefix ^ ((1 << maximumBit) - 1)
    }
    return result
}