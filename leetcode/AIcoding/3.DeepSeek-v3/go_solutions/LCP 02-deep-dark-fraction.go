func fraction(cont []int) []int {
    if len(cont) == 0 {
        return []int{0, 1}
    }
    n := len(cont)
    a, b := 1, cont[n-1]
    for i := n - 2; i >= 0; i-- {
        a, b = b, cont[i]*b + a
    }
    return []int{b, a}
}