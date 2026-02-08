func countNicePairs(nums []int) int {
    mod := int(1e9 + 7)
    freq := make(map[int]int)
    res := 0
    for _, num := range nums {
        rev := 0
        n := num
        for n > 0 {
            rev = rev*10 + n%10
            n /= 10
        }
        diff := num - rev
        res = (res + freq[diff]) % mod
        freq[diff]++
    }
    return res
}