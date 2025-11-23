func largestPalindromic(num string) string {
    count := make([]int, 10)
    for _, ch := range num {
        count[ch-'0']++
    }

    var half []byte
    for i := 9; i >= 0; i-- {
        if i == 0 && len(half) == 0 {
            continue
        }
        for count[i] >= 2 {
            half = append(half, byte(i)+'0')
            count[i] -= 2
        }
    }

    var mid byte
    for i := 9; i >= 0; i-- {
        if count[i] > 0 {
            mid = byte(i) + '0'
            break
        }
    }

    if len(half) == 0 && mid == 0 {
        return "0"
    }

    res := make([]byte, 0)
    res = append(res, half...)
    if mid != 0 {
        res = append(res, mid)
    }
    for i := len(half)-1; i >= 0; i-- {
        res = append(res, half[i])
    }

    return string(res)
}