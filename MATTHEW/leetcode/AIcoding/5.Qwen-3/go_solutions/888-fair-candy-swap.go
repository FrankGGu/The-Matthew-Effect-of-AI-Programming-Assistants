package main

func fairCandySwap(A []int, B []int) []int {
    sumA := 0
    sumB := 0
    setB := make(map[int]bool)
    for _, a := range A {
        sumA += a
    }
    for _, b := range B {
        sumB += b
        setB[b] = true
    }
    diff := (sumB - sumA) / 2
    for _, a := range A {
        if setB[a+diff] {
            return []int{a, a + diff}
        }
    }
    return nil
}