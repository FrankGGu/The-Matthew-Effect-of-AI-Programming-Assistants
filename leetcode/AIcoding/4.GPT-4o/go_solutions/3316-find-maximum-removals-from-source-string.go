func canRemove(s string, p string, k int) bool {
    j := 0
    for i := 0; i < len(s); i++ {
        if j < len(p) && s[i] == p[j] {
            j++
        }
        if j == len(p) {
            return true
        }
    }
    return false
}

func maximumRemovals(s string, p string, removable []int) int {
    left, right := 0, len(removable)
    for left < right {
        mid := left + (right-left)/2
        temp := []rune(s)
        for i := 0; i <= mid; i++ {
            temp[removable[i]] = ' '
        }
        if canRemove(string(temp), p, mid) {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}