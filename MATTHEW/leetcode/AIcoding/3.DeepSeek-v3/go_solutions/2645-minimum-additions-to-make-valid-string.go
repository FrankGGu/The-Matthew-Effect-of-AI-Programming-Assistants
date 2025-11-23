func addMinimum(word string) int {
    res := 0
    n := len(word)
    i := 0
    for i < n {
        if i+2 < n && word[i] == 'a' && word[i+1] == 'b' && word[i+2] == 'c' {
            i += 3
        } else if i+1 < n && word[i] == 'a' && word[i+1] == 'b' {
            res += 1
            i += 2
        } else if i+1 < n && word[i] == 'a' && word[i+1] == 'c' {
            res += 1
            i += 2
        } else if i+1 < n && word[i] == 'b' && word[i+1] == 'c' {
            res += 1
            i += 2
        } else if word[i] == 'a' {
            res += 2
            i += 1
        } else if word[i] == 'b' {
            res += 2
            i += 1
        } else if word[i] == 'c' {
            res += 2
            i += 1
        }
    }
    return res
}