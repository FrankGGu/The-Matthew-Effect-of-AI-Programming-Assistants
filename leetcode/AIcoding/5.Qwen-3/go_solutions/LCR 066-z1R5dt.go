package main

type MapSum struct {
    children [26]*MapSum
    value    int
}

func Constructor() MapSum {
    return MapSum{}
}

func (this *MapSum) Insert(key string, val int) {
    node := this
    for _, c := range key {
        if node.children[c-'a'] == nil {
            node.children[c-'a'] = &MapSum{}
        }
        node = node.children[c-'a']
    }
    node.value = val
}

func (this *MapSum) Sum(prefix string) int {
    node := this
    for _, c := range prefix {
        if node.children[c-'a'] == nil {
            return 0
        }
        node = node.children[c-'a']
    }
    return dfs(node)
}

func dfs(node *MapSum) int {
    if node == nil {
        return 0
    }
    res := node.value
    for i := 0; i < 26; i++ {
        res += dfs(node.children[i])
    }
    return res
}