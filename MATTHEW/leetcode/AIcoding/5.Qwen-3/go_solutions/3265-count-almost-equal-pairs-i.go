package main

func countAlmostEqualPairs(nums []int) int {
    n := len(nums)
    count := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            a, b := nums[i], nums[j]
            diff := 0
            for a > 0 || b > 0 {
                if a%10 != b%10 {
                    diff++
                }
                a /= 10
                b /= 10
            }
            if diff <= 2 {
                count++
            }
        }
    }
    return count
}