package main

type Encrypter struct {
    keyMap  map[rune][]rune
    valueMap map[rune]rune
}

func Constructor(keys []string, values []string) Encrypter {
    keyMap := make(map[rune][]rune)
    valueMap := make(map[rune]rune)
    for i := range keys {
        key := []rune(keys[i])
        value := []rune(values[i])
        keyMap[key[0]] = append(keyMap[key[0]], value...)
        valueMap[value[0]] = key[0]
    }
    return Encrypter{keyMap, valueMap}
}

func (e *Encrypter) Encrypt(word string) string {
    res := []rune{}
    for _, c := range word {
        res = append(res, e.keyMap[c]...)
    }
    return string(res)
}

func (e *Encrypter) Decrypt(word string) string {
    res := []rune{}
    i := 0
    for i < len(word) {
        j := i + 1
        for j < len(word) && e.valueMap[rune(word[j])] != 0 {
            j++
        }
        res = append(res, e.valueMap[rune(word[i])])
        i = j
    }
    return string(res)
}