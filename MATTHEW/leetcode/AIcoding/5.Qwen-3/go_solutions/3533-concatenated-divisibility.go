package main

func canMakeDivisibleByK(nums []int, k int) bool {
    count := make([]int, k)
    for _, num := range nums {
        mod := num % k
        if mod == 0 {
            continue
        }
        count[mod]++
    }
    for i := 1; i < k; i++ {
        if count[i] > 0 && count[k-i] != count[i] {
            return false
        }
    }
    return true
}