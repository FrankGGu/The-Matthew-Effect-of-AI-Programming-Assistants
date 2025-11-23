func minMovesToMakePalindrome(s string) int {
    n := len(s)
    left, right := 0, n-1
    moves := 0
    chars := []rune(s)

    for left < right {
        l, r := left, right
        for l < r && chars[l] != chars[r] {
            r--
        }
        if l == r {
            chars[left], chars[left+1] = chars[left+1], chars[left]
            moves++
        } else {
            for r < right {
                chars[r], chars[r+1] = chars[r+1], chars[r]
                r++
                moves++
            }
        }
        left++
        right--
    }
    return moves
}