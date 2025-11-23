package main

func genMaxGeneticDifference(parents []int, queries [][]int) []int {
    type Query struct {
        node, index int
    }
    n := len(parents)
    tree := make(map[int][]int)
    for i := 1; i < n; i++ {
        tree[parents[i]] = append(tree[parents[i]], i)
    }

    trie := &Trie{}
    result := make([]int, len(queries))

    var dfs func(node int, path *Trie)
    dfs = func(node int, path *Trie) {
        current := path
        for i := 30; i >= 0; i-- {
            bit := (node >> i) & 1
            if current.children[bit] == nil {
                current.children[bit] = &Trie{}
            }
            current = current.children[bit]
        }

        for _, q := range queries {
            if q[0] == node {
                val := q[1]
                maxDiff := 0
                curr := path
                for i := 30; i >= 0; i-- {
                    bit := (val >> i) & 1
                    if curr.children[1-bit] != nil {
                        maxDiff |= (1 << i)
                        curr = curr.children[1-bit]
                    } else {
                        curr = curr.children[bit]
                    }
                }
                result[q[2]] = maxDiff
            }
        }

        for _, child := range tree[node] {
            dfs(child, path)
        }
    }

    dfs(0, trie)
    return result
}

type Trie struct {
    children [2]*Trie
}