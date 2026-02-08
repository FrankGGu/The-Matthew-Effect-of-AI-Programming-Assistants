package main

import "sort"

func createSortedArray(instructions []int) int {
    mod := 1_000_000_007
    maxNum := 100_000
    bit := make([]int, maxNum+1)
    count := 0

    update := func(index, delta int) {
        for index <= maxNum {
            bit[index] += delta
            index += index & -index
        }
    }

    query := func(index int) int {
        sum := 0
        for index > 0 {
            sum += bit[index]
            index -= index & -index
        }
        return sum
    }

    for _, num := range instructions {
        lessCount := query(num-1)
        greaterCount := len(instructions) - count - query(num)
        count = (count + min(lessCount, greaterCount)) % mod
        update(num, 1)
    }

    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}