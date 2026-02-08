func advantageCount(A []int, B []int) []int {
    sort.Ints(A)
    n := len(A)
    result := make([]int, n)
    used := make([]bool, n)
    for i, b := range B {
        index := sort.Search(n, func(i int) bool {
            return A[i] > b
        })
        if index == n {
            index = 0
            for used[index] {
                index++
            }
        }
        result[i] = A[index]
        used[index] = true
    }
    return result
}