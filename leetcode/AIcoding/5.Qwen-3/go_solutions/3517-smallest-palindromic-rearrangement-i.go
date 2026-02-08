package main

func makePalindrome(n int) string {
    s := strconv.Itoa(n)
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    var left []byte
    var mid byte
    for i := 0; i < 26; i++ {
        if count[i]%2 == 1 {
            mid = byte('a' + i)
        }
    }
    for i := 0; i < 26; i++ {
        for count[i] > 1 {
            left = append(left, byte('a'+i))
            count[i] -= 2
        }
    }
    right := make([]byte, len(left))
    for i := 0; i < len(left); i++ {
        right[i] = left[len(left)-1-i]
    }
    result := append(left, mid)
    result = append(result, right...)
    return string(result)
}