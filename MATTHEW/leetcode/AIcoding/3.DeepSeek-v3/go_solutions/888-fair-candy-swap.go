func fairCandySwap(A []int, B []int) []int {
    sumA, sumB := 0, 0
    setB := make(map[int]bool)

    for _, num := range A {
        sumA += num
    }

    for _, num := range B {
        sumB += num
        setB[num] = true
    }

    delta := (sumB - sumA) / 2

    for _, num := range A {
        if setB[num + delta] {
            return []int{num, num + delta}
        }
    }

    return nil
}