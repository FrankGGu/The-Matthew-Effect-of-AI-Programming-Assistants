package main

func restoreIpAddresses(s string) []string {
    result := []string{}
    n := len(s)
    if n < 4 || n > 12 {
        return result
    }
    for i := 1; i <= 3 && i < n; i++ {
        if s[0] == '0' && i > 1 {
            continue
        }
        a, _ := strconv.Atoi(s[:i])
        if a > 255 {
            continue
        }
        for j := i + 1; j <= i+3 && j < n; j++ {
            if s[i] == '0' && j > i+1 {
                continue
            }
            b, _ := strconv.Atoi(s[i:j])
            if b > 255 {
                continue
            }
            for k := j + 1; k <= j+3 && k < n; k++ {
                if s[j] == '0' && k > j+1 {
                    continue
                }
                c, _ := strconv.Atoi(s[j:k])
                if c > 255 {
                    continue
                }
                d, _ := strconv.Atoi(s[k:])
                if d > 255 {
                    continue
                }
                result = append(result, fmt.Sprintf("%d.%d.%d.%d", a, b, c, d))
            }
        }
    }
    return result
}