type MagicDictionary struct {
	dict []string
}

func Constructor() MagicDictionary {
	return MagicDictionary{dict: []string{}}
}

func (this *MagicDictionary) BuildDict(dictionary []string) {
	this.dict = dictionary
}

func (this *MagicDictionary) Search(searchWord string) bool {
	for _, word := range this.dict {
		if len(word) != len(searchWord) {
			continue
		}
		diff := 0
		for i := 0; i < len(word); i++ {
			if word[i] != searchWord[i] {
				diff++
			}
		}
		if diff == 1 {
			return true
		}
	}
	return false
}