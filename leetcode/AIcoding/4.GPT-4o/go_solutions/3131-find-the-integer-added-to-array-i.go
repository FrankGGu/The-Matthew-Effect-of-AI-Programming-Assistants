func findAddedInteger(A []int, B []int) int {
    n, m := len(A), len(B)
    sumA, sumB := 0, 0

    for _, v := range A {
        sumA += v
    }
    for _, v := range B {
        sumB += v
    }

    return sumB - sumA
}