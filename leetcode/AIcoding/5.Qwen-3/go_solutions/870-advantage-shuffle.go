package main

func advantageCount(A []int, B []int) []int {
    sort.Ints(A)
    sort.Ints(B)
    bMap := make(map[int][]int)
    for _, b := range B {
        bMap[b] = append(bMap[b], 0)
    }
    i := len(A) - 1
    j := len(B) - 1
    for i >= 0 {
        if A[i] > B[j] {
            bMap[B[j]] = append(bMap[B[j]], A[i])
            i--
            j--
        } else {
            bMap[B[j]] = append(bMap[B[j]], A[i])
            i--
        }
    }
    result := make([]int, len(A))
    for k := range B {
        result[k] = bMap[B[k]][0]
        bMap[B[k]] = bMap[B[k]][1:]
    }
    return result
}