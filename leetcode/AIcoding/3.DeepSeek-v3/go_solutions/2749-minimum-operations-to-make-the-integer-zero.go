func makeTheIntegerZero(num1 int, num2 int) int {
    for k := 1; k <= 60; k++ {
        target := num1 - k * num2
        if target < 0 {
            continue
        }
        bits := bits.OnesCount64(uint64(target))
        if bits <= k && k <= target {
            return k
        }
    }
    return -1
}