func subarraysDivByK(A []int, K int) int {
    count := 0
    sum := 0
    modCount := make(map[int]int)
    modCount[0] = 1

    for _, num := range A {
        sum += num
        mod := ((sum % K) + K) % K
        count += modCount[mod]
        modCount[mod]++
    }

    return count
}