func minOperations(A []int, B []int) int {
    sort.Ints(A)
    sort.Ints(B)

    countA, countB := make([]int, 6), make([]int, 6)
    for _, num := range A {
        countA[num-1]++
    }
    for _, num := range B {
        countB[num-1]++
    }

    ops := 0
    for i := 0; i < 6; i++ {
        if countA[i] > countB[i] {
            ops += (countA[i] - countB[i]) / 2
        }
    }

    return ops
}