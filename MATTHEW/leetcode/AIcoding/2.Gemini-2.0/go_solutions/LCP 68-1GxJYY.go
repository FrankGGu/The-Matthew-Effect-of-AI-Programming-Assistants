func beautifulBouquet(flowers []int, cnt int) int {
    n := len(flowers)
    ans := 0
    mod := int(1e9 + 7)

    for length := 1; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            sub := flowers[i : i+length]
            freq := make(map[int]int)
            maxFreq := 0
            for _, flower := range sub {
                freq[flower]++
                if freq[flower] > maxFreq {
                    maxFreq = freq[flower]
                }
            }
            if maxFreq <= cnt {
                ans = (ans + 1) % mod
            }
        }
    }

    return ans
}