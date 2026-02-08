package main

func canBeEqual(target string, original string) bool {
    if len(target) != len(original) {
        return false
    }
    count := make([]int, 26)
    for i := 0; i < len(target); i++ {
        count[target[i]-'a']++
        count[original[i]-'a']--
    }
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}