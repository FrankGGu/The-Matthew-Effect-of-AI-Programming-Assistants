func sortArrayByParityII(A []int) []int {
    n := len(A)
    result := make([]int, n)
    evenIndex, oddIndex := 0, 1

    for _, num := range A {
        if num%2 == 0 {
            result[evenIndex] = num
            evenIndex += 2
        } else {
            result[oddIndex] = num
            oddIndex += 2
        }
    }

    return result
}