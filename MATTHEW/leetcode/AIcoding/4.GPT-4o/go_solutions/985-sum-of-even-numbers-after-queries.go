func sumEvenAfterQueries(A []int, queries [][]int) []int {
    sum := 0
    for _, num := range A {
        if num%2 == 0 {
            sum += num
        }
    }

    result := make([]int, len(queries))

    for i, query := range queries {
        val, index := query[0], query[1]
        if A[index]%2 == 0 {
            sum -= A[index]
        }
        A[index] += val
        if A[index]%2 == 0 {
            sum += A[index]
        }
        result[i] = sum
    }

    return result
}