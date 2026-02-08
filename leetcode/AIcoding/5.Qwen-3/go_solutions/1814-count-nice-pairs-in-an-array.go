package main

func countNicePairs(nums []int) int {
    mod := 1000000007
    count := make(map[int]int)
    result := 0
    for _, num := range nums {
        diff := num - reverse(num)
        result = (result + count[diff]) % mod
        count[diff]++
    }
    return result
}

func reverse(x int) int {
    rev := 0
    for x > 0 {
        rev = rev*10 + x%10
        x /= 10
    }
    return rev
}