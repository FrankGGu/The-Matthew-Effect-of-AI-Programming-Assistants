func beautifulIndices(s string, a string, b string, k int) []int {
    var res []int
    aIndices := kmp(s, a)
    bIndices := kmp(s, b)
    if len(aIndices) == 0 || len(bIndices) == 0 {
        return res
    }
    for _, ai := range aIndices {
        left := 0
        right := len(bIndices) - 1
        found := false
        for left <= right {
            mid := left + (right - left) / 2
            if abs(bIndices[mid] - ai) <= k {
                found = true
                break
            } else if bIndices[mid] < ai {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        if found {
            res = append(res, ai)
        }
    }
    return res
}

func kmp(text, pattern string) []int {
    var res []int
    n := len(text)
    m := len(pattern)
    if m == 0 || n < m {
        return res
    }
    lps := computeLPS(pattern)
    i := 0
    j := 0
    for i < n {
        if text[i] == pattern[j] {
            i++
            j++
            if j == m {
                res = append(res, i-j)
                j = lps[j-1]
            }
        } else {
            if j != 0 {
                j = lps[j-1]
            } else {
                i++
            }
        }
    }
    return res
}

func computeLPS(pattern string) []int {
    m := len(pattern)
    lps := make([]int, m)
    length := 0
    i := 1
    for i < m {
        if pattern[i] == pattern[length] {
            length++
            lps[i] = length
            i++
        } else {
            if length != 0 {
                length = lps[length-1]
            } else {
                lps[i] = 0
                i++
            }
        }
    }
    return lps
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}