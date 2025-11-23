func evenOddBit(n int) []int {
    evenCount, oddCount := 0, 0
    for i := 0; n > 0; i++ {
        if n&1 == 1 {
            if i%2 == 0 {
                evenCount++
            } else {
                oddCount++
            }
        }
        n >>= 1
    }
    return []int{evenCount, oddCount}
}