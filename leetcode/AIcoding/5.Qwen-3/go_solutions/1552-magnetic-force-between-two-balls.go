package main

func maxDistance(position []int, m int) int {
    sort.Ints(position)
    left, right := 1, position[len(position)-1]-position[0]
    var ans int

    for left <= right {
        mid := (left + right) / 2
        if canPlaceBalls(position, mid, m) {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return ans
}

func canPlaceBalls(position []int, minDist int, m int) bool {
    count := 1
    lastPos := position[0]

    for i := 1; i < len(position); i++ {
        if position[i]-lastPos >= minDist {
            count++
            lastPos = position[i]
            if count == m {
                return true
            }
        }
    }

    return count >= m
}