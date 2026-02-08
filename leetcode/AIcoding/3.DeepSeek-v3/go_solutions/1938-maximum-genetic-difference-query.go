type TrieNode struct {
    children [2]*TrieNode
    count int
}

func maximizeGeneticDifference(parents []int, queries [][]int) []int {
    n := len(parents)
    root := -1
    children := make([][]int, n)
    for i, p := range parents {
        if p == -1 {
            root = i
        } else {
            children[p] = append(children[p], i)
        }
    }

    queryMap := make(map[int][][]int)
    for idx, query := range queries {
        node, val := query[0], query[1]
        queryMap[node] = append(queryMap[node], []int{val, idx})
    }

    res := make([]int, len(queries))
    trieRoot := &TrieNode{}

    var dfs func(int)
    dfs = func(u int) {
        insert(trieRoot, u, 1)
        for _, q := range queryMap[u] {
            val, idx := q[0], q[1]
            res[idx] = findMax(trieRoot, val)
        }
        for _, v := range children[u] {
            dfs(v)
        }
        insert(trieRoot, u, -1)
    }
    dfs(root)
    return res
}

func insert(node *TrieNode, num, delta int) {
    for i := 17; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &TrieNode{}
        }
        node = node.children[bit]
        node.count += delta
    }
}

func findMax(node *TrieNode, num int) int {
    res := 0
    for i := 17; i >= 0; i-- {
        bit := (num >> i) & 1
        desired := 1 - bit
        if node.children[desired] != nil && node.children[desired].count > 0 {
            res |= (1 << i)
            node = node.children[desired]
        } else {
            node = node.children[bit]
        }
    }
    return res
}