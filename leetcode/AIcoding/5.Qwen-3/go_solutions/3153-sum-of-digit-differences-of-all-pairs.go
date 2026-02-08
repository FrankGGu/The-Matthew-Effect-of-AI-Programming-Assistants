package main

func sumOfDigitDifferences(nums []int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            a, b := nums[i], nums[j]
            diff := 0
            for a > 0 || b > 0 {
                digitA := a % 10
                digitB := b % 10
                if digitA != digitB {
                    diff++
                }
                a /= 10
                b /= 10
            }
            res += diff
        }
    }
    return res
}