func beautifulBouquet(flowers []int, cnt int) int {
    mod := int(1e9 + 7)
    res := 0
    freq := make(map[int]int)
    left := 0

    for right := 0; right < len(flowers); right++ {
        freq[flowers[right]]++
        for freq[flowers[right]] > cnt {
            freq[flowers[left]]--
            left++
        }
        res = (res + right - left + 1) % mod
    }
    return res
}