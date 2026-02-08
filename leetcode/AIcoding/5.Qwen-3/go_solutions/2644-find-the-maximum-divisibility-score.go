package main

func maxDivisibilityScore(nums []int, divisors []int) int {
    maxCount := 0
    result := divisors[0]
    for _, d := range divisors {
        count := 0
        for _, num := range nums {
            if num%d == 0 {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
            result = d
        } else if count == maxCount && d < result {
            result = d
        }
    }
    return result
}