package main

func decodeAtIndex(s string, k int) string {
    var size int
    for _, c := range s {
        if c >= '0' && c <= '9' {
            size *= int(c - '0')
        } else {
            size++
        }
    }

    for i := len(s) - 1; i >= 0; i-- {
        c := s[i]
        if c >= '0' && c <= '9' {
            k %= size
            size /= int(c - '0')
        } else {
            if k == size {
                return string(c)
            }
            size--
        }
    }
    return ""
}