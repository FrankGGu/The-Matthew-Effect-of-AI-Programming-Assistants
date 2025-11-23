package main

type MagicDictionary struct {
    words map[int][]string
}

func Constructor() MagicDictionary {
    return MagicDictionary{
        words: make(map[int][]string),
    }
}

func (m *MagicDictionary) BuildDict(dictionary []string) {
    for _, word := range dictionary {
        m.words[len(word)] = append(m.words[len(word)], word)
    }
}

func (m *MagicDictionary) Search(word string) bool {
    for _, w := range m.words[len(word)] {
        diff := 0
        for i := 0; i < len(word); i++ {
            if word[i] != w[i] {
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