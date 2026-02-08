package main

func consecutiveNumbersSum(n int) int {
    count := 0
    k := 1
    for {
        if n < k {
            break
        }
        if (n - k)%(k+1) == 0 {
            count++
        }
        k++
    }
    return count
}