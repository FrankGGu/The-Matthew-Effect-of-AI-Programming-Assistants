func prefixesDivBy5(A []int) []bool {
    result := make([]bool, len(A))
    current := 0
    for i, num := range A {
        current = (current*2 + num) % 5
        result[i] = current == 0
    }
    return result
}