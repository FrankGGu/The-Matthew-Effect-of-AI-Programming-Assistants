package main

func canArrange(arr []int, k int) bool {
    count := make([]int, k)
    for _, num := range arr {
        mod := num % k
        if mod < 0 {
            mod += k
        }
        count[mod]++
    }
    if count[0]%2 != 0 {
        return false
    }
    for i := 1; i < k/2+1; i++ {
        if count[i] != count[k-i] {
            return false
        }
    }
    return true
}