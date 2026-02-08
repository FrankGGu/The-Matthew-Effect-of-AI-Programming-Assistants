type Encrypter struct {
	keyMap  map[byte]string
	valMap  map[string][]byte
	values  []string
	dictionary []string
}

func Constructor(keys []byte, values []string, dictionary []string) Encrypter {
	keyMap := make(map[byte]string)
	valMap := make(map[string][]byte)

	for i := 0; i < len(keys); i++ {
		keyMap[keys[i]] = values[i]
		if _, ok := valMap[values[i]]; !ok {
			valMap[values[i]] = make([]byte, 0)
		}
		valMap[values[i]] = append(valMap[values[i]], keys[i])
	}

	return Encrypter{keyMap: keyMap, valMap: valMap, values: values, dictionary: dictionary}
}

func (this *Encrypter) Encrypt(word1 string) string {
	encrypted := ""
	for i := 0; i < len(word1); i++ {
		if val, ok := this.keyMap[word1[i]]; ok {
			encrypted += val
		} else {
			return ""
		}
	}
	return encrypted
}

func (this *Encrypter) Decrypt(word2 string) int {
	count := 0
	for _, word := range this.dictionary {
		encrypted := this.Encrypt(word)
		if encrypted == word2 {
			count++
		}
	}
	return count
}