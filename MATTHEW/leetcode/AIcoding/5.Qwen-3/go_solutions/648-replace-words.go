package main

func replaceWords(dict []string, sentence string) string {
    words := make(map[string]bool)
    for _, word := range dict {
        words[word] = true
    }

    res := ""
    i := 0
    for i < len(sentence) {
        j := i
        for j < len(sentence) && sentence[j] != ' ' {
            j++
        }
        current := sentence[i:j]
        for k := 1; k <= len(current); k++ {
            if words[current[:k]] {
                res += current[:k]
                break
            }
        }
        if len(res) == 0 || res[len(res)-1] != ' ' {
            res += " "
        }
        i = j + 1
    }
    if len(res) > 0 {
        res = res[:len(res)-1]
    }
    return res
}