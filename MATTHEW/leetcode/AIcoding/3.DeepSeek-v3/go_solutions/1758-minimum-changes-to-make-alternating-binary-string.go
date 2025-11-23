func minOperations(s string) int {
    count1 := 0
    count2 := 0
    for i, c := range s {
        if i % 2 == 0 {
            if c != '0' {
                count1++
            } else {
                count2++
            }
        } else {
            if c != '1' {
                count1++
            } else {
                count2++
            }
        }
    }
    if count1 < count2 {
        return count1
    }
    return count2
}