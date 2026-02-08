func maximumRemovals(s string, p string, removable []int) int {
    left, right := 0, len(removable)
    result := 0

    for left <= right {
        mid := left + (right-left)/2
        if canForm(s, p, removable[:mid]) {
            result = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return result
}

func canForm(s string, p string, removable []int) bool {
    removed := make(map[int]struct{})
    for _, index := range removable {
        removed[index] = struct{}{}
    }

    j := 0
    for i := 0; i < len(s); i++ {
        if _, ok := removed[i]; ok {
            continue
        }
        if j < len(p) && s[i] == p[j] {
            j++
        }
    }

    return j == len(p)
}