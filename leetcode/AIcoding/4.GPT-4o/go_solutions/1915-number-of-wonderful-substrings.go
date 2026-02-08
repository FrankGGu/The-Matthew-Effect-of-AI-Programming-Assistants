func wonderfulSubstrings(word string) int64 {
    count := make([]int, 1024)
    count[0] = 1
    res := int64(0)
    mask := 0

    for _, c := range word {
        mask ^= 1 << (c - 'a')
        res += int64(count[mask])

        for i := 0; i < 10; i++ {
            res += int64(count[mask^ (1 << i)])
        }

        count[mask]++
    }

    return res
}