type Encrypter struct {
    keysToValues map[byte]string
    dictionary   map[string]int
}

func Constructor(keys []byte, values []string, dictionary []string) Encrypter {
    keysToValues := make(map[byte]string)
    for i, key := range keys {
        keysToValues[key] = values[i]
    }

    dict := make(map[string]int)
    for _, word := range dictionary {
        encrypted := ""
        valid := true
        for _, ch := range word {
            if val, ok := keysToValues[byte(ch)]; ok {
                encrypted += val
            } else {
                valid = false
                break
            }
        }
        if valid {
            dict[encrypted]++
        }
    }

    return Encrypter{keysToValues, dict}
}

func (this *Encrypter) Encrypt(word1 string) string {
    encrypted := ""
    for _, ch := range word1 {
        if val, ok := this.keysToValues[byte(ch)]; ok {
            encrypted += val
        } else {
            return ""
        }
    }
    return encrypted
}

func (this *Encrypter) Decrypt(word2 string) int {
    return this.dictionary[word2]
}

/**
 * Your Encrypter object will be instantiated and called as such:
 * obj := Constructor(keys, values, dictionary);
 * param_1 := obj.Encrypt(word1);
 * param_2 := obj.Decrypt(word2);
 */