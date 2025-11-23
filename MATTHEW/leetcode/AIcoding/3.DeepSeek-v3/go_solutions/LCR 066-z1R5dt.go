type MapSum struct {
    children map[rune]*MapSum
    value    int
}

func Constructor() MapSum {
    return MapSum{children: make(map[rune]*MapSum)}
}

func (this *MapSum) Insert(key string, val int) {
    node := this
    for _, ch := range key {
        if _, ok := node.children[ch]; !ok {
            node.children[ch] = &MapSum{children: make(map[rune]*MapSum)}
        }
        node = node.children[ch]
    }
    node.value = val
}

func (this *MapSum) Sum(prefix string) int {
    node := this
    for _, ch := range prefix {
        if _, ok := node.children[ch]; !ok {
            return 0
        }
        node = node.children[ch]
    }
    return node.sumHelper()
}

func (this *MapSum) sumHelper() int {
    sum := this.value
    for _, child := range this.children {
        sum += child.sumHelper()
    }
    return sum
}

/**
 * Your MapSum object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Insert(key,val);
 * param_2 := obj.Sum(prefix);
 */