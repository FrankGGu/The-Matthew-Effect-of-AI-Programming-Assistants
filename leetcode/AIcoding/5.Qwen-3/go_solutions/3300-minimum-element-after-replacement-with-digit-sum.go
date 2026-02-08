package main

func minElement(nums []int) int {
    sum := func(n int) int {
        s := 0
        for n > 0 {
            s += n % 10
            n /= 10
        }
        return s
    }
    min := nums[0]
    for _, num := range nums {
        s := sum(num)
        if s < min {
            min = s
        }
    }
    return min
}