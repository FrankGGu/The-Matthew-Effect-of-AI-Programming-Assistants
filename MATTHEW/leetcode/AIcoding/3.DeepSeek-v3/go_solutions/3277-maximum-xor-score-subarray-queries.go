type TrieNode struct {
    children [2]*TrieNode
}

func maximizeXor(nums []int, queries [][]int) []int {
    sort.Ints(nums)
    for i := range queries {
        queries[i] = append(queries[i], i)
    }
    sort.Slice(queries, func(i, j int) bool {
        return queries[i][1] < queries[j][1]
    })

    res := make([]int, len(queries))
    root := &TrieNode{}
    ptr := 0

    for _, q := range queries {
        x, m, idx := q[0], q[1], q[2]
        for ptr < len(nums) && nums[ptr] <= m {
            node := root
            for i := 30; i >= 0; i-- {
                bit := (nums[ptr] >> i) & 1
                if node.children[bit] == nil {
                    node.children[bit] = &TrieNode{}
                }
                node = node.children[bit]
            }
            ptr++
        }

        if ptr == 0 {
            res[idx] = -1
            continue
        }

        node := root
        maxXor := 0
        for i := 30; i >= 0; i-- {
            bit := (x >> i) & 1
            if node.children[1-bit] != nil {
                maxXor |= 1 << i
                node = node.children[1-bit]
            } else {
                node = node.children[bit]
            }
        }
        res[idx] = maxXor
    }
    return res
}