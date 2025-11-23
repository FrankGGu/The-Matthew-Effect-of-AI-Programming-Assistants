package main

func canBeEqual(target string, input string) bool {
    if len(target) != len(input) {
        return false
    }
    for i := 0; i < len(target); i++ {
        if target[i] != input[i] {
            if target[i] == 'R' && input[i] == 'L' {
                return false
            }
            if target[i] == 'L' && input[i] == 'R' {
                return false
            }
        }
    }
    return true
}