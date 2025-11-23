func makeFancyString(s string) string {
    result := []byte{}
    count := 0
    prev := byte(0)

    for i := 0; i < len(s); i++ {
        if s[i] == prev {
            count++
        } else {
            count = 1
            prev = s[i]
        }
        if count < 3 {
            result = append(result, s[i])
        }
    }

    return string(result)
}