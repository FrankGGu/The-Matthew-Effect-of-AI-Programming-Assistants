package main

func maxLength(arr []string) int {
    var dfs func(int, map[byte]bool) int
    dfs = func(index int, chars map[byte]bool) int {
        if index == len(arr) {
            return len(chars)
        }
        // Check if current string can be added without duplicates
        canAdd := true
        newChars := make(map[byte]bool)
        for k, v := range chars {
            newChars[k] = v
        }
        for i := 0; i < len(arr[index]); i++ {
            if newChars[arr[index][i]] {
                canAdd = false
                break
            }
            newChars[arr[index][i]] = true
        }
        // Option 1: skip current string
        option1 := dfs(index+1, newChars)
        // Option 2: take current string if possible
        option2 := 0
        if canAdd {
            option2 = dfs(index+1, newChars)
        }
        return max(option1, option2)
    }
    return dfs(0, make(map[byte]bool))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}