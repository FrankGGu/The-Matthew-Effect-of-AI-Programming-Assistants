func maximumRemovals(s string, p string, removable []int) int {
    left, right := 0, len(removable)
    for left <= right {
        mid := left + (right-left)/2
        if isSubsequence(s, p, removable, mid) {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}

func isSubsequence(s string, p string, removable []int, k int) bool {
    removed := make(map[int]bool)
    for i := 0; i < k; i++ {
        removed[removable[i]] = true
    }
    i, j := 0, 0
    for i < len(s) && j < len(p) {
        if !removed[i] && s[i] == p[j] {
            j++
        }
        i++
    }
    return j == len(p)
}