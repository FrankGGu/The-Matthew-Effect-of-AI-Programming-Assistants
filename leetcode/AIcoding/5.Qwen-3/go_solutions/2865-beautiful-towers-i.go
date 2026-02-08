package main

func numberOfBeautifulTowers(heights []int) int {
    n := len(heights)
    left := make([]int, n)
    right := make([]int, n)

    for i := 0; i < n; i++ {
        if i == 0 {
            left[i] = 1
        } else {
            if heights[i] > heights[i-1] {
                left[i] = left[i-1] + 1
            } else {
                left[i] = 1
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        if i == n-1 {
            right[i] = 1
        } else {
            if heights[i] > heights[i+1] {
                right[i] = right[i+1] + 1
            } else {
                right[i] = 1
            }
        }
    }

    result := 0
    for i := 0; i < n; i++ {
        result += left[i] + right[i] - 1
    }

    return result
}