package main

type MapSum struct {
    children map[rune]*MapSum
    value    int
}

func Constructor() MapSum {
    return MapSum{
        children: make(map[rune]*MapSum),
        value:    0,
    }
}

func (m *MapSum) Insert(key string, val int) {
    node := m
    for _, ch := range key {
        if node.children[ch] == nil {
            node.children[ch] = &MapSum{
                children: make(map[rune]*MapSum),
                value:    0,
            }
        }
        node = node.children[ch]
    }
    node.value = val
}

func (m *MapSum) Sum(prefix string) int {
    node := m
    for _, ch := range prefix {
        if node.children[ch] == nil {
            return 0
        }
        node = node.children[ch]
    }
    return dfs(node)
}

func dfs(node *MapSum) int {
    sum := node.value
    for _, child := range node.children {
        sum += dfs(child)
    }
    return sum
}