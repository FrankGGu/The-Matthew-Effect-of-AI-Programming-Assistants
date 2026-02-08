package main

import "sort"

func maxDistance(position []int, m int) int {
    sort.Ints(position)
    left, right := 1, position[len(position)-1]-position[0]

    var canPlaceBalls func(distance int) bool
    canPlaceBalls = func(distance int) bool {
        count, lastPosition := 1, position[0]
        for i := 1; i < len(position); i++ {
            if position[i]-lastPosition >= distance {
                count++
                lastPosition = position[i]
                if count == m {
                    return true
                }
            }
        }
        return false
    }

    for left <= right {
        mid := left + (right-left)/2
        if canPlaceBalls(mid) {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return right
}