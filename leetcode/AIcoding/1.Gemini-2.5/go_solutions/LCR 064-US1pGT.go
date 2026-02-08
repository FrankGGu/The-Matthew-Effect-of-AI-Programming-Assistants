type MagicDictionary struct {
	words []string
}

func Constructor() MagicDictionary {
	return MagicDictionary{
		words: []string{},
	}
}

func (this *MagicDictionary) BuildDict(dictionary []string) {
	this.words = dictionary
}

func (this *MagicDictionary) Search(searchWord string) bool {
	for _, dictWord := range this.words {
		if len(dictWord) != len(searchWord) {
			continue
		}

		diffCount := 0
		for i := 0; i < len(dictWord); i++ {
			if dictWord[i] != searchWord[i] {
				diffCount++
			}
			if diffCount > 1 { // Optimization: if more than one difference, no need to continue
				break
			}
		}

		if diffCount == 1 {
			return true
		}
	}
	return false
}