func compressedString(word string) string {
    n := len(word)
    if n == 0 {
        return ""
    }

    var res []byte
    current := word[0]
    count := 1

    for i := 1; i < n; i++ {
        if word[i] == current {
            count++
        } else {
            for count > 0 {
                cnt := min(count, 9)
                res = append(res, byte('0'+cnt), current)
                count -= cnt
            }
            current = word[i]
            count = 1
        }
    }

    for count > 0 {
        cnt := min(count, 9)
        res = append(res, byte('0'+cnt), current)
        count -= cnt
    }

    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}