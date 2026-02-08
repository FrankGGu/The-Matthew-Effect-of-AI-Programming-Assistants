func canArrange(arr []int, k int) bool {
    mod := make([]int, k)
    for _, num := range arr {
        remainder := num % k
        if remainder < 0 {
            remainder += k
        }
        mod[remainder]++
    }
    if mod[0]%2 != 0 {
        return false
    }
    for i := 1; i <= k/2; i++ {
        if mod[i] != mod[k-i] {
            return false
        }
    }
    return true
}