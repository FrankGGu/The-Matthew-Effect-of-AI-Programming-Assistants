func minSwaps(s string) int {
    balance := 0
    swaps := 0
    for _, c := range s {
        if c == '[' {
            balance++
        } else {
            balance--
        }
        if balance < 0 {
            swaps++
            balance += 2
        }
    }
    return swaps
}