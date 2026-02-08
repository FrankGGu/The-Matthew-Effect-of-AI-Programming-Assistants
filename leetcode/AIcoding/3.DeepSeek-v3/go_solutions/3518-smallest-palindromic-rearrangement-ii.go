func smallestPalindrome(s string) string {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }

    oddChar := rune(0)
    for c, cnt := range freq {
        if cnt%2 != 0 {
            if oddChar != 0 {
                return ""
            }
            oddChar = c
        }
    }

    left := make([]rune, 0)
    keys := make([]rune, 0)
    for c := range freq {
        keys = append(keys, c)
    }
    sort.Slice(keys, func(i, j int) bool {
        return keys[i] < keys[j]
    })

    for _, c := range keys {
        count := freq[c]
        if c == oddChar {
            count--
        }
        for i := 0; i < count/2; i++ {
            left = append(left, c)
        }
    }

    right := make([]rune, len(left))
    for i := 0; i < len(left); i++ {
        right[i] = left[len(left)-1-i]
    }

    res := make([]rune, 0)
    res = append(res, left...)
    if oddChar != 0 {
        res = append(res, oddChar)
    }
    res = append(res, right...)

    return string(res)
}