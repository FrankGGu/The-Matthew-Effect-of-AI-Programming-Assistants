package main

func findSmallestInteger(nums []int, k int) int {
    count := make(map[int]int)
    for _, num := range nums {
        mod := num % k
        if mod < 0 {
            mod += k
        }
        count[mod]++
    }

    for i := 0; i < len(nums)+1; i++ {
        mod := i % k
        if mod < 0 {
            mod += k
        }
        if count[mod] == 0 {
            return i
        }
        count[mod]--
    }
    return len(nums)
}