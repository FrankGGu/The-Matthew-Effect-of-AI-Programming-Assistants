package main

func countPairs(nums []int) int {
    mod := 1000000007
    maxSum := 200000
    count := make([]int, maxSum+1)
    result := 0

    for _, num := range nums {
        for i := 0; i <= 20; i++ {
            target := 1 << i
            if target >= num && count[target-num] > 0 {
                result = (result + count[target-num]) % mod
            }
        }
        count[num]++
    }

    return result
}