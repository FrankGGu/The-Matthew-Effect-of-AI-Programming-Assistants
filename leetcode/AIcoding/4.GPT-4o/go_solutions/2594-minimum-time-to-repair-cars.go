package main

import (
    "sort"
)

func repairCars(rank []int, cars int) int {
    left, right := 1, 1e14
    for left < right {
        mid := (left + right) / 2
        if canRepair(rank, cars, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canRepair(rank []int, cars int, time int) bool {
    total := 0
    for _, r := range rank {
        total += int(time/r)
        if total >= cars {
            return true
        }
    }
    return total >= cars
}