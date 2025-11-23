package main

func findOriginalString(word string) string {
    n := len(word)
    res := make([]byte, 0, n)
    i := 0
    for i < n {
        if word[i] >= '0' && word[i] <= '9' {
            j := i + 1
            for j < n && word[j] >= '0' && word[j] <= '9' {
                j++
            }
            count, _ := strconv.Atoi(word[i:j])
            i = j
            if i < n {
                res = append(res, []byte(word[i])...)
                for k := 1; k < count; k++ {
                    res = append(res, []byte(word[i])...)
                }
            }
        } else {
            res = append(res, word[i])
        }
        i++
    }
    return string(res)
}