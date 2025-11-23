func minOperations(s string) int {
    count1, count2 := 0, 0
    for i, ch := range s {
        if (ch-'0') != byte(i%2) {
            count1++
        }
        if (ch-'0') != byte((i+1)%2) {
            count2++
        }
    }
    if count1 < count2 {
        return count1
    }
    return count2
}