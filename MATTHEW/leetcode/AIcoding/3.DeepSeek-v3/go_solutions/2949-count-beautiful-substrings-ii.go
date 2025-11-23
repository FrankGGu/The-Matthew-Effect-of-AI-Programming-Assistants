func beautifulSubstrings(s string, k int) int64 {
    n := len(s)
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        if vowels[s[i]] {
            prefix[i+1] = prefix[i] + 1
        } else {
            prefix[i+1] = prefix[i]
        }
    }

    mod := 1
    temp := k
    for temp % 2 == 0 {
        mod *= 2
        temp /= 2
    }
    for temp % 5 == 0 {
        mod *= 5
        temp /= 5
    }
    mod *= 2

    count := 0
    freq := make(map[[2]int]int)
    freq[[2]int{0, 0}] = 1

    for i := 1; i <= n; i++ {
        v := prefix[i]
        c := i - v
        key := [2]int{v - c, v % mod}
        count += freq[key]
        freq[key]++
    }

    return int64(count)
}