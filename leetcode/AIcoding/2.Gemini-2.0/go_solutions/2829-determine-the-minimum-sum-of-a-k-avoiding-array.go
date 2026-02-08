func minimumSum(n int, k int) int {
    used := make(map[int]bool)
    ans := 0
    count := 0
    for i := 1; count < n; i++ {
        if _, ok := used[i]; !ok {
            if i < k {
                ans += i
                used[k-i] = true
                count++
            } else {
                ans += i
                count++
            }
        }
    }
    return ans
}