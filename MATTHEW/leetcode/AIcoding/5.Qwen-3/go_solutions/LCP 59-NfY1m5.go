package main

func minDistance(boxes []int) int {
    sort.Ints(boxes)
    n := len(boxes)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + boxes[i]
    }
    res := math.MaxInt32
    for i := 0; i < n; i++ {
        left := prefix[i]
        right := prefix[n] - prefix[i+1]
        dist := 0
        for j := 0; j < i; j++ {
            dist += boxes[i] - boxes[j]
        }
        for j := i + 1; j < n; j++ {
            dist += boxes[j] - boxes[i]
        }
        if dist < res {
            res = dist
        }
    }
    return res
}