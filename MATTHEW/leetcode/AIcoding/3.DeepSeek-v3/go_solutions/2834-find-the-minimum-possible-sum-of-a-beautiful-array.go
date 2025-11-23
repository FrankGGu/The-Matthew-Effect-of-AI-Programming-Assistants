func minimumPossibleSum(n int, target int) int64 {
    used := make(map[int]bool)
    sum := int64(0)
    num := 1
    for i := 0; i < n; {
        if !used[target - num] {
            used[num] = true
            sum += int64(num)
            i++
        }
        num++
    }
    return sum
}