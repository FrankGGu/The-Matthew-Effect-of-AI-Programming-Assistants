func fairCandySwap(A []int, B []int) []int {
    sumA, sumB := 0, 0
    setB := make(map[int]struct{})

    for _, a := range A {
        sumA += a
    }
    for _, b := range B {
        sumB += b
        setB[b] = struct{}{}
    }

    delta := (sumA - sumB) / 2
    for _, a := range A {
        if _, exists := setB[a - delta]; exists {
            return []int{a, a - delta}
        }
    }
    return nil
}