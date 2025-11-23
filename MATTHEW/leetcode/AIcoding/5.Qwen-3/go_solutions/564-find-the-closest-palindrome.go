package main

func nearestPalindrome(n string) string {
    if len(n) == 1 {
        return strconv.Itoa(int(n[0] - '0' - 1))
    }
    candidates := make([]string, 0)
    length := len(n)
    half := (length + 1) / 2
    prefix := n[:half]
    num, _ := strconv.Atoi(prefix)
    for i := -1; i <= 1; i++ {
        newNum := strconv.Itoa(num + i)
        if length%2 == 0 {
            candidate := newNum + reverse(newNum)
            candidates = append(candidates, candidate)
        } else {
            candidate := newNum + reverse(newNum[:len(newNum)-1])
            candidates = append(candidates, candidate)
        }
    }
    candidates = append(candidates, "9")
    candidates = append(candidates, "10"+strings.Repeat("0", length-2)+"1")
    candidates = append(candidates, "1"+strings.Repeat("0", length-1)+"1")
    minDiff := math.MaxInt64
    result := ""
    for _, c := range candidates {
        if len(c) != len(n) && len(c) != len(n)+1 {
            continue
        }
        diff := int(math.Abs(float64(toInt(n)) - float64(toInt(c))))
        if diff < minDiff {
            minDiff = diff
            result = c
        } else if diff == minDiff {
            if toInt(c) < toInt(result) {
                result = c
            }
        }
    }
    return result
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func toInt(s string) int {
    num, _ := strconv.Atoi(s)
    return num
}