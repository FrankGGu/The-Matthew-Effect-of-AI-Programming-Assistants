type MagicDictionary struct {
    dict map[string]int
}

func Constructor() MagicDictionary {
    return MagicDictionary{dict: make(map[string]int)}
}

func (this *MagicDictionary) BuildDict(dictionary []string) {
    for _, word := range dictionary {
        this.dict[word]++
    }
}

func (this *MagicDictionary) Search(searchWord string) bool {
    for word := range this.dict {
        if len(word) != len(searchWord) {
            continue
        }
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
    return false
}