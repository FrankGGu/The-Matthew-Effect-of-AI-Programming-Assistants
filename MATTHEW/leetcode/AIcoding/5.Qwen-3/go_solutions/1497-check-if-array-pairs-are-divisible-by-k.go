package main

func canArrange(arr []int, k int) bool {
    freq := make([]int, k)
    for _, num := range arr {
        mod := num % k
        if mod < 0 {
            mod += k
        }
        freq[mod]++
    }
    if freq[0]%2 != 0 {
        return false
    }
    for i := 1; i < k/2+1; i++ {
        if freq[i] != freq[k-i] {
            return false
        }
    }
    return true
}