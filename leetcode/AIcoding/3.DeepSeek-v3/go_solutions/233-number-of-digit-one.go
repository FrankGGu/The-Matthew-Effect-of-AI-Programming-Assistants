func countDigitOne(n int) int {
    count := 0
    for i := 1; i <= n; i *= 10 {
        divider := i * 10
        count += (n / divider) * i
        remainder := n % divider
        if remainder >= 2*i {
            count += i
        } else if remainder >= i {
            count += remainder - i + 1
        }
    }
    return count
}