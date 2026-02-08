func nearestPalindromic(n string) string {
    num, _ := strconv.ParseInt(n, 10, 64)
    candidates := make(map[int64]bool)
    length := len(n)

    candidates[int64(math.Pow10(length-1))-1] = true
    candidates[int64(math.Pow10(length))+1] = true

    prefix, _ := strconv.ParseInt(n[:(length+1)/2], 10, 64)
    for i := -1; i <= 1; i++ {
        p := prefix + int64(i)
        if p <= 0 {
            continue
        }
        sp := strconv.FormatInt(p, 10)
        var candidateStr string
        if length % 2 == 0 {
            candidateStr = sp + reverse(sp)
        } else {
            candidateStr = sp + reverse(sp[:len(sp)-1])
        }
        candidate, _ := strconv.ParseInt(candidateStr, 10, 64)
        candidates[candidate] = true
    }

    delete(candidates, num)

    var res int64
    minDiff := int64(math.MaxInt64)
    for candidate := range candidates {
        diff := abs(candidate - num)
        if diff < minDiff || (diff == minDiff && candidate < res) {
            minDiff = diff
            res = candidate
        }
    }

    return strconv.FormatInt(res, 10)
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func abs(x int64) int64 {
    if x < 0 {
        return -x
    }
    return x
}