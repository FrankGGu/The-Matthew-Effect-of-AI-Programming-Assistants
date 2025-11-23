package main

func sortArrayByParityII(A []int) []int {
    n := len(A)
    for i, j := 0, 1; i < n && j < n; i += 2 {
        if A[i]%2 == 0 {
            continue
        }
        for j < n && A[j]%2 == 1 {
            j += 2
        }
        if j < n {
            A[i], A[j] = A[j], A[i]
        }
    }
    return A
}