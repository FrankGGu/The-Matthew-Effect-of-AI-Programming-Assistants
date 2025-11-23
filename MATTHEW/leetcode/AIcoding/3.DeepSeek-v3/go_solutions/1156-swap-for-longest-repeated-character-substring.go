func maxRepOpt1(text string) int {
    count := make(map[byte]int)
    for i := range text {
        count[text[i]]++
    }

    res := 0
    for i := 0; i < len(text); {
        j := i
        for j < len(text) && text[j] == text[i] {
            j++
        }
        currCnt := j - i
        if currCnt < count[text[i]] && (j < len(text) || i > 0) {
            res = max(res, currCnt+1)
        }
        k := j + 1
        for k < len(text) && text[k] == text[i] {
            k++
        }
        res = max(res, min(k-i, count[text[i]]))
        i = j
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}