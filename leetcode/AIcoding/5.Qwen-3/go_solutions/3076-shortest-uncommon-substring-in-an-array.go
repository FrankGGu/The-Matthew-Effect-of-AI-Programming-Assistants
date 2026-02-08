package main

func shortestUncommonSubstr(s []string) string {
    count := make(map[string]int)
    for _, str := range s {
        n := len(str)
        for i := 0; i < n; i++ {
            for j := i + 1; j <= n; j++ {
                substr := str[i:j]
                count[substr]++
            }
        }
    }

    minLen := len(s[0]) + 1
    result := ""
    for _, str := range s {
        n := len(str)
        for i := 0; i < n; i++ {
            for j := i + 1; j <= n; j++ {
                substr := str[i:j]
                if count[substr] == 1 {
                    if len(substr) < minLen {
                        minLen = len(substr)
                        result = substr
                    }
                }
            }
        }
    }

    return result
}