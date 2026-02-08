func minOperations(A []int, B []int) int {
    sumA, sumB := 0, 0
    for _, num := range A {
        sumA += num
    }
    for _, num := range B {
        sumB += num
    }

    if sumA == sumB {
        return 0
    }

    if sumA > sumB {
        A, B = B, A
        sumA, sumB = sumB, sumA
    }

    diff := sumB - sumA
    count := make([]int, 7)
    for _, num := range A {
        count[num]++
    }
    for _, num := range B {
        count[6-num]++
    }

    operations := 0
    for i := 6; i > 0 && diff > 0; i-- {
        for count[i] > 0 && diff > 0 {
            count[i]--
            diff -= i
            operations++
        }
    }

    if diff > 0 {
        return -1
    }

    return operations
}