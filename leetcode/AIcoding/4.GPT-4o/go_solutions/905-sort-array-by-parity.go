func sortArrayByParity(A []int) []int {
    even := []int{}
    odd := []int{}

    for _, num := range A {
        if num%2 == 0 {
            even = append(even, num)
        } else {
            odd = append(odd, num)
        }
    }

    return append(even, odd...)
}