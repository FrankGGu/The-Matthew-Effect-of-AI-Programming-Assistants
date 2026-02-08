func numberOfWays(s string) int64 {
    var total, count0, count1, ways0, ways1 int64
    for _, ch := range s {
        if ch == '0' {
            ways1 += count1
            total += ways0
            count0++
        } else {
            ways0 += count0
            total += ways1
            count1++
        }
    }
    return total
}