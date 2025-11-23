func diStringMatch(s string) []int {
    n := len(s)
    perm := make([]int, n+1)
    low := 0
    high := n

    for i := 0; i < n; i++ {
        if s[i] == 'I' {
            perm[i] = low
            low++
        } else { // s[i] == 'D'
            perm[i] = high
            high--
        }
    }
    perm[n] = low // or high, they will be equal at this point

    return perm
}