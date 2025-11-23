func smallestRangeI(A []int, K int) int {
    minA, maxA := A[0], A[0]
    for _, num := range A {
        if num < minA {
            minA = num
        }
        if num > maxA {
            maxA = num
        }
    }
    if maxA-minA <= 2*K {
        return 0
    }
    return maxA - minA - 2*K
}