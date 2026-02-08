func decode(encoded []int) []int {
    n := len(encoded) + 1
    perm := make([]int, n)
    totalXOR := 0
    for i := 1; i <= n; i++ {
        totalXOR ^= i
    }
    oddXOR := 0
    for i := 1; i < n; i += 2 {
        oddXOR ^= encoded[i]
    }
    perm[0] = totalXOR ^ oddXOR
    for i := 1; i < n; i++ {
        perm[i] = perm[i-1] ^ encoded[i-1]
    }
    return perm
}