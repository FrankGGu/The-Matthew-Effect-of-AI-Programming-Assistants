type Trie struct {
    children map[string]*Trie
    key      string
    deleted  bool
}

func deleteDuplicateFolder(paths [][]string) [][]string {
    root := &Trie{children: make(map[string]*Trie)}
    for _, path := range paths {
        node := root
        for _, name := range path {
            if _, ok := node.children[name]; !ok {
                node.children[name] = &Trie{children: make(map[string]*Trie)}
            }
            node = node.children[name]
        }
    }

    seen := make(map[string]*Trie)
    var dfs func(*Trie) string
    dfs = func(node *Trie) string {
        if len(node.children) == 0 {
            return ""
        }
        keys := make([]string, 0, len(node.children))
        for name, child := range node.children {
            keys = append(keys, name+"("+dfs(child)+")")
        }
        sort.Strings(keys)
        key := strings.Join(keys, "")
        if n, ok := seen[key]; ok {
            n.deleted = true
            node.deleted = true
        } else {
            seen[key] = node
        }
        return key
    }
    dfs(root)

    var res [][]string
    var path []string
    var collect func(*Trie)
    collect = func(node *Trie) {
        if node.deleted {
            return
        }
        if len(path) > 0 {
            tmp := make([]string, len(path))
            copy(tmp, path)
            res = append(res, tmp)
        }
        for name, child := range node.children {
            path = append(path, name)
            collect(child)
            path = path[:len(path)-1]
        }
    }
    collect(root)
    return res
}