package main

func restoreIPAddresses(s string) []string {
    result := []string{}
    backtrack(s, 0, "", 0, &result)
    return result
}

func backtrack(s string, start int, current string, parts int, result *[]string) {
    if parts == 4 {
        if start == len(s) {
            *result = append(*result, current)
        }
        return
    }

    for i := start; i < len(s); i++ {
        if s[start] == '0' && i > start {
            break
        }
        num, _ := strconv.Atoi(s[start:i+1])
        if num > 255 {
            break
        }
        if current == "" {
            backtrack(s, i+1, s[start:i+1], parts+1, result)
        } else {
            backtrack(s, i+1, current+"."+s[start:i+1], parts+1, result)
        }
    }
}