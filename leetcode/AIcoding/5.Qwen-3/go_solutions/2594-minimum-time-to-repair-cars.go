package main

func minRepairTime(carTimes []int, target int) int {
    left := 0
    right := 0

    for _, t := range carTimes {
        if t > right {
            right = t
        }
    }

    for left < right {
        mid := left + (right-left)/2
        count := 0
        for _, t := range carTimes {
            count += mid / t
            if count >= target {
                break
            }
        }
        if count >= target {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}