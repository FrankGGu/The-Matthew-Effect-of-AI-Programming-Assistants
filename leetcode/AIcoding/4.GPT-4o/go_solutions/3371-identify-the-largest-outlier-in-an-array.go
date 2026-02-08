package main

import (
    "math"
)

func largestOutlier(nums []int) int {
    n := len(nums)
    if n < 3 {
        return -1
    }

    mean := 0.0
    for _, num := range nums {
        mean += float64(num)
    }
    mean /= float64(n)

    stdDev := 0.0
    for _, num := range nums {
        stdDev += math.Pow(float64(num)-mean, 2)
    }
    stdDev = math.Sqrt(stdDev / float64(n))

    threshold := mean + 2*stdDev
    largestOutlier := math.MinInt64
    for _, num := range nums {
        if float64(num) > threshold {
            if num > largestOutlier {
                largestOutlier = num
            }
        }
    }

    if largestOutlier == math.MinInt64 {
        return -1
    }
    return largestOutlier
}