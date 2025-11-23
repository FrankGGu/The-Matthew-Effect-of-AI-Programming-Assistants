func numOfSubarrays(arr []int) int {
    mod := int(1e9 + 7)
    even, odd := 1, 0
    ans := 0
    for _, num := range arr {
        if num%2 == 0 {
            even++
        } else {
            even, odd = odd, even
            odd++
        }
        ans = (ans + odd) % mod
    }
    return ans
}