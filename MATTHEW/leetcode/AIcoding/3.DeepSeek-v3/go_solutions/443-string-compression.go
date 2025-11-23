func compress(chars []byte) int {
    n := len(chars)
    if n == 0 {
        return 0
    }

    write := 0
    count := 1

    for read := 1; read < n; read++ {
        if chars[read] == chars[read-1] {
            count++
        } else {
            chars[write] = chars[read-1]
            write++
            if count > 1 {
                cntStr := strconv.Itoa(count)
                for _, c := range cntStr {
                    chars[write] = byte(c)
                    write++
                }
            }
            count = 1
        }
    }

    chars[write] = chars[n-1]
    write++
    if count > 1 {
        cntStr := strconv.Itoa(count)
        for _, c := range cntStr {
            chars[write] = byte(c)
            write++
        }
    }

    return write
}