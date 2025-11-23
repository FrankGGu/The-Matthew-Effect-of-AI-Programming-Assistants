func lenLongestFibSubseq(A []int) int {
    n := len(A)
    index := make(map[int]int)
    for i, num := range A {
        index[num] = i
    }

    longest := make([][]int, n)
    maxLength := 0

    for j := 1; j < n; j++ {
        for i := 0; i < j; i++ {
            k := A[j] - A[i]
            if k >= A[i] {
                break
            }
            if idx, exists := index[k]; exists && idx < i {
                length := 2
                if longest[i] != nil {
                    length = longest[i][0] + 1
                }
                longest[j] = append(longest[j], length)
                maxLength = max(maxLength, length)
            }
        }
    }

    if maxLength < 3 {
        return 0
    }
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}