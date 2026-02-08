func longestDecomposition(text string) int {
    n := len(text)
    left, right := 0, n-1
    ans := 0

    for left <= right {
        var l, r int
        for l = 0; left+l <= right && text[left+l] == text[right-l]; l++ {
        }
        if l == 0 {
            break
        }
        ans += 1
        left += l
        right -= l
    }

    if left > right {
        return ans
    }
    return ans + 1
}