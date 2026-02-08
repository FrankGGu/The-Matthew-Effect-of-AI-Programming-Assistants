func longestPalindrome(s string) int {
    count := make([]int, 128)
    for _, c := range s {
        count[c]++
    }
    length := 0
    oddFound := false
    for _, v := range count {
        if v%2 == 0 {
            length += v
        } else {
            length += v - 1
            oddFound = true
        }
    }
    if oddFound {
        length++
    }
    return length
}