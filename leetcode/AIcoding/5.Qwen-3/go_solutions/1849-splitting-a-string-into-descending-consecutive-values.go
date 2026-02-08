package main

func splitString(s string) bool {
    var backtrack func(int, int, int) bool
    backtrack = func(index int, count int, prev int) bool {
        if index == len(s) {
            return count >= 2
        }
        for i := index; i < len(s); i++ {
            num := 0
            for j := index; j <= i; j++ {
                num = num*10 + int(s[j]-'0')
            }
            if count == 0 {
                if backtrack(i+1, 1, num) {
                    return true
                }
            } else {
                if prev == num+1 {
                    if backtrack(i+1, count+1, num) {
                        return true
                    }
                }
            }
        }
        return false
    }
    return backtrack(0, 0, 0)
}