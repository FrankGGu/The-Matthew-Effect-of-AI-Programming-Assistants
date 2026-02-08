package main

func replaceWords(dict []string, sentence string) string {
    words := make(map[string]bool)
    for _, word := range dict {
        words[word] = true
    }

    var result []rune
    i := 0
    n := len(sentence)

    for i < n {
        j := i
        for j < n && sentence[j] != ' ' {
            j++
        }
        current := sentence[i:j]
        found := false
        for k := 1; k <= len(current); k++ {
            if words[string(current[:k])] {
                result = append(result, []rune(string(current[:k]))...)
                found = true
                break
            }
        }
        if !found {
            result = append(result, []rune(current)...)
        }
        if j < n {
            result = append(result, ' ')
        }
        i = j + 1
    }

    return string(result)
}