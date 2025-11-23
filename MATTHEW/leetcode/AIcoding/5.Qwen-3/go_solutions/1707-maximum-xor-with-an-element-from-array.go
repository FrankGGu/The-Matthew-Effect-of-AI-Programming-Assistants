package main

func maximizeXOR(a []int, queries [][]int) []int {
    sort.Slice(a, func(i, j int) bool {
        return a[i] < a[j]
    })

    type query struct {
        idx   int
        x     int
        value int
    }

    queriesWithIndex := make([]query, len(queries))
    for i, q := range queries {
        queriesWithIndex[i] = query{i, q[0], q[1]}
    }

    sort.Slice(queriesWithIndex, func(i, j int) bool {
        return queriesWithIndex[i].x < queriesWithIndex[j].x
    })

    result := make([]int, len(queries))
    root := &TrieNode{}

    idx := 0
    for _, q := range queriesWithIndex {
        for idx < len(a) && a[idx] <= q.x {
            insert(root, a[idx])
            idx++
        }
        result[q.idx] = findMaxXOR(root, q.value)
    }

    return result
}

type TrieNode struct {
    children [2]*TrieNode
}

func insert(node *TrieNode, num int) {
    for i := 30; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &TrieNode{}
        }
        node = node.children[bit]
    }
}

func findMaxXOR(node *TrieNode, num int) int {
    if node == nil {
        return 0
    }
    maxNum := 0
    for i := 30; i >= 0; i-- {
        bit := (num >> i) & 1
        toggledBit := 1 - bit
        if node.children[toggledBit] != nil {
            maxNum |= (1 << i)
            node = node.children[toggledBit]
        } else {
            node = node.children[bit]
        }
    }
    return maxNum
}