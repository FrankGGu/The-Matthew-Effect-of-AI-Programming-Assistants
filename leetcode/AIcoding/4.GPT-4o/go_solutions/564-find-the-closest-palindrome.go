func nearestPalindromic(n string) string {
    length := len(n)
    candidates := map[string]struct{}{}

    candidates["0"] = struct{}{}
    candidates[fmt.Sprintf("%d", int(math.Pow(10, float64(length-1))) - 1)] = struct{}{}
    candidates[fmt.Sprintf("%d", int(math.Pow(10, float64(length))) + 1)] = struct{}{}

    prefix := n[:(length+1)/2]
    for i := -1; i <= 1; i++ {
        newPrefix := fmt.Sprintf("%d", atoi(prefix)+i)
        if length%2 == 0 {
            candidates[newPrefix+reverse(newPrefix)] = struct{}{}
        } else {
            candidates[newPrefix+reverse(newPrefix[:len(newPrefix)-1])] = struct{}{}
        }
    }

    closest := ""
    minDiff := math.MaxInt64
    for candidate := range candidates {
        if candidate != n {
            diff := abs(atoi(candidate) - atoi(n))
            if diff < minDiff || (diff == minDiff && atoi(candidate) < atoi(closest)) {
                minDiff = diff
                closest = candidate
            }
        }
    }

    return closest
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func atoi(s string) int {
    res, _ := strconv.Atoi(s)
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}