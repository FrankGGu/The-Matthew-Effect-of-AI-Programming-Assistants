package main

import "fmt"

func minString(s1, s2, s3 string) string {
    all := []string{s1, s2, s3}
    result := ""

    var dfs func(path string, index int)
    dfs = func(path string, index int) {
        if index == 3 {
            if result == "" || len(path) < len(result) {
                result = path
            }
            return
        }

        for i := 0; i < len(path); i++ {
            if path[i:] == all[index][:len(path)-i] {
                dfs(path + all[index][len(path)-i:], index+1)
                return
            }
        }
        dfs(path+all[index], index+1)
    }

    dfs("", 0)
    return result
}

func shortestString(s1, s2, s3 string) string {
    ans := minString(s1, s2, s3)
    return ans
}

func main() {
    s1 := "abc"
    s2 := "bca"
    s3 := "cab"
    fmt.Println(shortestString(s1, s2, s3))
}