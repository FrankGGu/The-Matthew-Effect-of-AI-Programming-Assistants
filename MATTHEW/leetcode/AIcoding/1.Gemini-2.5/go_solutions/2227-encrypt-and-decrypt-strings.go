package main

import (
	"strings"
)

type Encrypter struct {
	keyToValue          map[byte]string
	encryptedWordCounts map[string]int
}

func Constructor(keys []byte, values []string, dictionary []string) Encrypter {
	keyToValue := make(map[byte]string)
	for i := 0; i < len(keys); i++ {
		keyToValue[keys[i]] = values[i]
	}

	encrypter := Encrypter{
		keyToValue:          keyToValue,
		encryptedWordCounts: make(map[string]int),
	}

	for _, word := range dictionary {
		encryptedWord := encrypter.Encrypt(word)
		if encryptedWord != "" {
			encrypter.encryptedWordCounts[encryptedWord]++
		}
	}

	return encrypter
}

func (this *Encrypter) Encrypt(word1 string) string {
	var sb strings.Builder
	sb.Grow(len(word1) * 2)
	for i := 0; i < len(word1); i++ {
		ch := word1[i]
		val, ok := this.keyToValue[ch]
		if !ok {
			return ""
		}
		sb.WriteString(val)
	}
	return sb.String()
}

func (this *Encrypter) Decrypt(word2 string) int {
	return this.encryptedWordCounts[word2]
}