type MagicDictionary struct {
    words map[string]bool
}

func Constructor() MagicDictionary {
    return MagicDictionary{words: make(map[string]bool)}
}

func (this *MagicDictionary) BuildDict(dictionary []string) {
    for _, word := range dictionary {
        this.words[word] = true
    }
}

func (this *MagicDictionary) Search(searchWord string) bool {
    for word := range this.words {
        if len(word) == len(searchWord) {
            diff := 0
            for i := 0; i < len(word); i++ {
                if word[i] != searchWord[i] {
                    diff++
                }
                if diff > 1 {
                    break
                }
            }
            if diff == 1 {
                return true
            }
        }
    }
    return false
}