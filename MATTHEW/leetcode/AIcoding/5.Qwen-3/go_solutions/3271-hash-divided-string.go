package main

func splitString(s string, k int) bool {
    var dfs func(int, int, int) bool
    dfs = func(index, count, prev int) bool {
        if index == len(s) {
            return count == k
        }
        for i := index; i < len(s); i++ {
            num := 0
            for j := index; j <= i; j++ {
                num = num*10 + int(s[j]-'0')
            }
            if count < k-1 && dfs(i+1, count+1, num) {
                return true
            }
            if count == k-1 && i == len(s)-1 {
                return true
            }
        }
        return false
    }
    return dfs(0, 0, 0)
}