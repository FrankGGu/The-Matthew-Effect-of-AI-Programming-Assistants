func numOfSubarrays(arr []int) int {
    mod := int(1e9 + 7)
    odd, even, sum, res := 0, 1, 0, 0
    for _, num := range arr {
        sum += num
        if sum % 2 == 1 {
            res += even
            odd++
        } else {
            res += odd
            even++
        }
        res %= mod
    }
    return res
}