type WordDictionary struct {
    children map[rune]*WordDictionary
    isWord   bool
}

func Constructor() WordDictionary {
    return WordDictionary{children: make(map[rune]*WordDictionary)}
}

func (this *WordDictionary) AddWord(word string) {
    node := this
    for _, char := range word {
        if _, ok := node.children[char]; !ok {
            node.children[char] = &WordDictionary{children: make(map[rune]*WordDictionary)}
        }
        node = node.children[char]
    }
    node.isWord = true
}

func (this *WordDictionary) Search(word string) bool {
    return this.searchHelper(word, 0)
}

func (this *WordDictionary) searchHelper(word string, index int) bool {
    if index == len(word) {
        return this.isWord
    }

    char := rune(word[index])

    if char == '.' {
        for _, child := range this.children {
            if child.searchHelper(word, index+1) {
                return true
            }
        }
        return false
    } else {
        if _, ok := this.children[char]; !ok {
            return false
        }
        return this.children[char].searchHelper(word, index+1)
    }
}