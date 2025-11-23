package main

func minOperations(boxes string) []int {
    n := len(boxes)
    res := make([]int, n)
    left := make([]int, n)
    right := make([]int, n)

    count := 0
    for i := 1; i < n; i++ {
        left[i] = left[i-1] + count
        if boxes[i-1] == '1' {
            count++
        }
    }

    count = 0
    for i := n - 2; i >= 0; i-- {
        right[i] = right[i+1] + count
        if boxes[i+1] == '1' {
            count++
        }
    }

    for i := 0; i < n; i++ {
        res[i] = left[i] + right[i]
    }

    return res
}