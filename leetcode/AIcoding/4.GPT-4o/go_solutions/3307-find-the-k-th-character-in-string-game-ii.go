func findKthCharacter(s string, k int) byte {
    n := len(s)
    if k <= n {
        return s[k-1]
    }

    k -= n
    length := n
    sequence := s

    for {
        if k <= length {
            return sequence[k-1]
        }
        k -= length
        length *= 2
        sequence += sequence
    }
}