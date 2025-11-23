package main

func maximumNumberOfAlloys(budget int, materials []int, target int, k int) int {
    left := 0
    right := 1e5

    for left <= right {
        mid := (left + right) / 2
        total := 0
        for i := 0; i < len(materials); i++ {
            need := mid * target
            if materials[i] < need {
                total += need - materials[i]
            }
        }
        if total <= budget {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}