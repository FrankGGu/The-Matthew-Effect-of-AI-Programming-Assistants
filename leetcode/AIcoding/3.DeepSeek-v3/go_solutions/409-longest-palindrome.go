func longestPalindrome(s string) int {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }

    length := 0
    oddFound := false

    for _, count := range freq {
        if count % 2 == 0 {
            length += count
        } else {
            length += count - 1
            oddFound = true
        }
    }

    if oddFound {
        length++
    }

    return length
}