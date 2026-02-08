func decode(encoded []int) []int {
    n := len(encoded) + 1
    total := 0
    for i := 1; i <= n; i++ {
        total ^= i
    }
    odd := 0
    for i := 1; i < len(encoded); i += 2 {
        odd ^= encoded[i]
    }
    perm := make([]int, n)
    perm[0] = total ^ odd
    for i := 1; i < n; i++ {
        perm[i] = perm[i-1] ^ encoded[i-1]
    }
    return perm
}