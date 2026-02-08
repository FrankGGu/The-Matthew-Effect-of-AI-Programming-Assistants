package main

type WordDictionary struct {
    children [26]*WordDictionary
    isEnd    bool
}

func Constructor() WordDictionary {
    return WordDictionary{}
}

func (this *WordDictionary) AddWord(word string) {
    node := this
    for _, c := range word {
        if node.children[c-'a'] == nil {
            node.children[c-'a'] = &WordDictionary{}
        }
        node = node.children[c-'a']
    }
    node.isEnd = true
}

func (this *WordDictionary) Search(word string) bool {
    return this.searchHelper(word, 0)
}

func (this *WordDictionary) searchHelper(word string, index int) bool {
    if index == len(word) {
        return this.isEnd
    }
    c := word[index]
    if c != '.' {
        if this.children[c-'a'] == nil {
            return false
        }
        return this.children[c-'a'].searchHelper(word, index+1)
    } else {
        for i := 0; i < 26; i++ {
            if this.children[i] != nil && this.children[i].searchHelper(word, index+1) {
                return true
            }
        }
        return false
    }
}