func minimumSum(n int, k int) int {
    sum := 0
    used := make(map[int]bool)
    num := 1
    for i := 0; i < n; {
        if !used[k-num] {
            sum += num
            used[num] = true
            i++
        }
        num++
    }
    return sum
}