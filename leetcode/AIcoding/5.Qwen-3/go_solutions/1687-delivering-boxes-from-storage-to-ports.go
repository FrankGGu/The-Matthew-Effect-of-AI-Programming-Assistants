package main

func maxDistanceToClosestPerson(seats []int) int {
    n := len(seats)
    left := make([]int, n)
    right := make([]int, n)

    for i := 0; i < n; i++ {
        if seats[i] == 1 {
            left[i] = 0
        } else {
            if i > 0 {
                left[i] = left[i-1] + 1
            } else {
                left[i] = n
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        if seats[i] == 1 {
            right[i] = 0
        } else {
            if i < n-1 {
                right[i] = right[i+1] + 1
            } else {
                right[i] = n
            }
        }
    }

    maxDist := 0
    for i := 0; i < n; i++ {
        dist := min(left[i], right[i])
        if dist > maxDist {
            maxDist = dist
        }
    }

    return maxDist
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}