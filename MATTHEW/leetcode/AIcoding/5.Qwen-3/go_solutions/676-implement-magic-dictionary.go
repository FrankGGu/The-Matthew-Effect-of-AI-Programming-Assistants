package main

type MagicDictionary struct {
    words map[string]bool
}

func Constructor() MagicDictionary {
    return MagicDictionary{
        words: make(map[string]bool),
    }
}

func (this *MagicDictionary) BuildDict(dict []string) {
    for _, word := range dict {
        this.words[word] = true
    }
}

func (this *MagicDictionary) Search(word string) bool {
    for w := range this.words {
        if len(w) != len(word) {
            continue
        }
        diff := 0
        for i := 0; i < len(w); i++ {
            if w[i] != word[i] {
                diff++
                if diff > 1 {
                    break
                }
            }
        }
        if diff == 1 {
            return true
        }
    }
    return false
}