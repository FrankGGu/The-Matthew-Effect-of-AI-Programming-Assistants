package main

func countSpecialQuadruplets(nums []int) int {
    n := len(nums)
    count := 0
    for a := 0; a < n; a++ {
        for b := a + 1; b < n; b++ {
            for c := b + 1; c < n; c++ {
                for d := c + 1; d < n; d++ {
                    if nums[a]+nums[b] == nums[c]+nums[d] {
                        count++
                    }
                }
            }
        }
    }
    return count
}