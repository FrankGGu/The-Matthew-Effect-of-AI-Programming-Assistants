package main

func findValidSplit(n int, nums []int) int {
    left := make(map[int]int)
    right := make(map[int]int)
    for _, num := range nums {
        for i := 2; i*i <= num; i++ {
            for num%i == 0 {
                right[i]++
                num /= i
            }
        }
        if num > 1 {
            right[num]++
        }
    }
    for i := 0; i < n; i++ {
        num := nums[i]
        for j := 2; j*j <= num; j++ {
            for num%j == 0 {
                left[j]++
                right[j]--
                num /= j
            }
        }
        if num > 1 {
            left[num]++
            right[num]--
        }
        valid := true
        for k := range left {
            if right[k] > 0 {
                valid = false
                break
            }
        }
        if valid {
            return i
        }
    }
    return -1
}