package main

import "sort"

func smallestMissingPositive(nums []int) int {
    sort.Ints(nums)
    smallestMissing := 1

    for _, num := range nums {
        if num == smallestMissing {
            smallestMissing++
        } else if num > smallestMissing {
            break
        }
    }

    return smallestMissing
}