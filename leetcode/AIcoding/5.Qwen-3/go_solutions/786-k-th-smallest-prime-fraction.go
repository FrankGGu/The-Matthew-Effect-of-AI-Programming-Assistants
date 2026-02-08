package main

func kthSmallestPrimeFraction(arr []int, k int) []int {
    n := len(arr)
    left, right := 0.0, 1.0

    for left < right {
        mid := (left + right) / 2
        count := 0
        maxFraction := 0.0
        var result []int

        for i := 0; i < n; i++ {
            for j := i + 1; j < n; j++ {
                if float64(arr[i])/float64(arr[j]) <= mid {
                    count++
                    if float64(arr[i])/float64(arr[j]) > maxFraction {
                        maxFraction = float64(arr[i]) / float64(arr[j])
                        result = []int{arr[i], arr[j]}
                    }
                }
            }
        }

        if count < k {
            left = mid
        } else {
            right = mid
        }
    }

    return result
}