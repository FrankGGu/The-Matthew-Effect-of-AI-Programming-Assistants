package main

type StreamChecker struct {
    trie     map[byte]*map[byte]*map[byte]bool
    maxLen   int
    queue    []byte
}

func Constructor(words []string) StreamChecker {
    sc := StreamChecker{
        trie:   make(map[byte]*map[byte]*map[byte]bool),
        maxLen: 0,
    }
    for _, word := range words {
        if len(word) > sc.maxLen {
            sc.maxLen = len(word)
        }
        node := sc.trie
        for i := len(word) - 1; i >= 0; i-- {
            b := word[i]
            if _, ok := node[b]; !ok {
                node[b] = make(map[byte]*map[byte]bool)
            }
            node = node[b]
        }
        node['#'] = &map[byte]bool{}
    }
    return sc
}

func (this *StreamChecker) Query(letter byte) bool {
    this.queue = append(this.queue, letter)
    if len(this.queue) > this.maxLen {
        this.queue = this.queue[1:]
    }
    node := this.trie
    for i := len(this.queue) - 1; i >= 0; i-- {
        b := this.queue[i]
        if _, ok := node[b]; !ok {
            return false
        }
        node = node[b]
        if _, ok := node['#']; ok {
            return true
        }
    }
    return false
}