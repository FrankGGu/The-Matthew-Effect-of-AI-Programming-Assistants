func fourSumCount(A []int, B []int, C []int, D []int) int {
    countAB := make(map[int]int)
    for _, a := range A {
        for _, b := range B {
            countAB[a+b]++
        }
    }

    count := 0
    for _, c := range C {
        for _, d := range D {
            count += countAB[-(c + d)]
        }
    }

    return count
}