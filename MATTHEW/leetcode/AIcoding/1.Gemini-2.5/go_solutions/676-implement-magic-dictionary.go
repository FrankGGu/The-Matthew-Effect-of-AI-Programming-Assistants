type MagicDictionary struct {
	words map[int][]string
}

func Constructor() MagicDictionary {
	return MagicDictionary{
		words: make(map[int][]string),
	}
}

func (this *MagicDictionary) BuildDict(dictionary []string) {
	for _, word := range dictionary {
		length := len(word)
		this.words[length] = append(this.words[length], word)
	}
}

func (this *MagicDictionary) Search(searchWord string) bool {
	searchLen := len(searchWord)

	if dictWords, ok := this.words[searchLen]; ok {
		for _, dictWord := range dictWords {
			diffCount := 0
			for i := 0; i < searchLen; i++ {
				if searchWord[i] != dictWord[i] {
					diffCount++
				}
				if diffCount > 1 {
					break
				}
			}
			if diffCount == 1 {
				return true
			}
		}
	}
	return false
}