func orderlyQueue(s string, k int) string {
    if k == 1 {
        min := s
        for i := 0; i < len(s); i++ {
            rotated := s[i:] + s[:i]
            if rotated < min {
                min = rotated
            }
        }
        return min
    } else {
        bytes := []byte(s)
        sort.Slice(bytes, func(i, j int) bool {
            return bytes[i] < bytes[j]
        })
        return string(bytes)
    }
}