func secondHighest(s string) int {
    first, second := -1, -1
    for _, c := range s {
        if c >= '0' && c <= '9' {
            num := int(c - '0')
            if num > first {
                second = first
                first = num
            } else if num < first && num > second {
                second = num
            }
        }
    }
    return second
}