package main

func maxPower(cities []int) int {
    n := len(cities)
    left, right := 0, n-1
    result := 0

    for left < right {
        mid := (left + right) / 2
        if canPower(cities, mid) {
            result = mid
            left = mid + 1
        } else {
            right = mid
        }
    }

    return result
}

func canPower(cities []int, power int) bool {
    count := 0
    prev := -1000000

    for i, city := range cities {
        if city == 1 {
            if i-prev > power {
                count++
                prev = i
            }
        }
    }

    return count <= 1
}