func minimumPossibleSum(n int, target int) int64 {
    s := make(map[int]bool)
    sum := int64(0)
    count := 0
    i := 1
    for count < n {
        if _, ok := s[i]; !ok {
            if _, ok := s[target-i]; !ok {
                s[i] = true
                sum += int64(i)
                count++
            }
        }
        i++
    }
    return sum
}