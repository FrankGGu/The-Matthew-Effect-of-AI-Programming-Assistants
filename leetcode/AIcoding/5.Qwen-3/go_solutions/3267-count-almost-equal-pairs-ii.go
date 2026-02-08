package main

func countAlmostEqualPairs(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if isAlmostEqual(nums[i], nums[j]) {
                count++
            }
        }
    }
    return count
}

func isAlmostEqual(a, b int) bool {
    diff := 0
    for a > 0 || b > 0 {
        if a%10 != b%10 {
            diff++
            if diff > 2 {
                return false
            }
        }
        a /= 10
        b /= 10
    }
    return diff <= 2
}