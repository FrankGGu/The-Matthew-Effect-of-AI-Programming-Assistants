package main

import (
    "fmt"
    "sort"
)

func findLCP(strings []string) string {
    if len(strings) == 0 {
        return ""
    }
    sort.Strings(strings)
    first := strings[0]
    last := strings[len(strings)-1]
    lcp := ""
    for i := 0; i < len(first) && i < len(last) && first[i] == last[i]; i++ {
        lcp += string(first[i])
    }
    return lcp
}

func main() {
    strings := []string{"flower", "flow", "flight"}
    fmt.Println(findLCP(strings))
}