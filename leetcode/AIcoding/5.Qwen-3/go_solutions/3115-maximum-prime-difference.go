package main

func maxPrimeDifference(nums []int) int {
    isPrime := func(n int) bool {
        if n < 2 {
            return false
        }
        for i := 2; i*i <= n; i++ {
            if n%i == 0 {
                return false
            }
        }
        return true
    }

    first := -1
    last := -1

    for i, num := range nums {
        if isPrime(num) {
            if first == -1 {
                first = i
            }
            last = i
        }
    }

    return last - first
}