package main

func maxScore(arr []int) int {
    n := len(arr)
    if n < 3 {
        return 0
    }

    sort.Ints(arr)

    maxScore := 0
    for i := 1; i < n-1; i++ {
        score := arr[i-1] * arr[i] * arr[i+1]
        if score > maxScore {
            maxScore = score
        }
    }

    return maxScore
}