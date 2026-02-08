func beautifulIndices(s string, a string, b string, k int) []int {
    var res []int
    aIndices := kmp(s, a)
    bIndices := kmp(s, b)
    if len(aIndices) == 0 || len(bIndices) == 0 {
        return res
    }
    ptr := 0
    for _, ai := range aIndices {
        for ptr < len(bIndices) && bIndices[ptr] < ai - k {
            ptr++
        }
        if ptr < len(bIndices) && abs(bIndices[ptr] - ai) <= k {
            res = append(res, ai)
        }
    }
    return res
}

func kmp(text, pattern string) []int {
    n, m := len(text), len(pattern)
    if m == 0 {
        return nil
    }
    lps := computeLPS(pattern)
    var res []int
    i, j := 0, 0
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