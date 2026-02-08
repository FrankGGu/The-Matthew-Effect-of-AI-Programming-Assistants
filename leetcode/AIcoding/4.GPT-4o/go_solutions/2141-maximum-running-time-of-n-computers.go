func maxRunTime(n int, batteries []int) int {
    totalBattery := 0
    for _, b := range batteries {
        totalBattery += b
    }

    left, right := 1, totalBattery/n
    for left < right {
        mid := (left + right + 1) / 2
        if canRun(n, batteries, mid) {
            left = mid
        } else {
            right = mid - 1
        }
    }

    return left
}

func canRun(n int, batteries []int, target int) bool {
    totalBattery := 0
    for _, b := range batteries {
        if b > target {
            totalBattery += target
        } else {
            totalBattery += b
        }
    }
    return totalBattery >= n*target
}