package main

func reversePrefix(word string, ch byte) string {
    for i := 0; i < len(word); i++ {
        if word[i] == ch {
            s := []byte(word)
            for j := 0; j < i/2; j++ {
                s[j], s[i-j] = s[i-j], s[j]
            }
            return string(s)
        }
    }
    return word
}