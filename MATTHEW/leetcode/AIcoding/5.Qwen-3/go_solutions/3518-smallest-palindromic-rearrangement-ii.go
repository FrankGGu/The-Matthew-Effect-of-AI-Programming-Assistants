package main

func makePalindrome(s string) string {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }

    var half []byte
    var mid byte
    for i := 0; i < 26; i++ {
        if count[i]%2 == 1 {
            mid = byte('a' + i)
        }
        for j := 0; j < count[i]/2; j++ {
            half = append(half, byte('a'+i))
        }
    }

    sort.Slice(half, func(i, j int) bool { return half[i] < half[j] })

    var res []byte
    res = append(res, half...)
    if mid != 0 {
        res = append(res, mid)
    }
    for i := len(half) - 1; i >= 0; i-- {
        res = append(res, half[i])
    }

    return string(res)
}