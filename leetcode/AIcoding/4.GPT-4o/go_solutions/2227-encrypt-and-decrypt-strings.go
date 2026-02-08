type Encrypter struct {
    mapping map[rune]rune
    reverse  map[rune]rune
    key      string
}

func Constructor(key string, encrypt []string) Encrypter {
    encrypter := Encrypter{
        mapping: make(map[rune]rune),
        reverse: make(map[rune]rune),
        key:     key,
    }
    used := make(map[rune]bool)
    for i, c := range key {
        if !used[c] {
            encrypter.mapping[rune('a'+i)] = rune(encrypt[len(used)])
            encrypter.reverse[rune(encrypt[len(used)])] = rune('a' + i)
            used[c] = true
        }
    }
    return encrypter
}

func (this *Encrypter) Encrypt(word1 string) string {
    var result strings.Builder
    for _, c := range word1 {
        if val, ok := this.mapping[c]; ok {
            result.WriteRune(val)
        } else {
            return ""
        }
    }
    return result.String()
}

func (this *Encrypter) Decrypt(word2 string) string {
    if len(word2)%2 != 0 {
        return ""
    }
    var result strings.Builder
    for i := 0; i < len(word2); i += 2 {
        pair := word2[i : i+2]
        if val, ok := this.reverse[rune(pair[0])]; ok {
            result.WriteRune(val)
        } else {
            return ""
        }
    }
    return result.String()
}