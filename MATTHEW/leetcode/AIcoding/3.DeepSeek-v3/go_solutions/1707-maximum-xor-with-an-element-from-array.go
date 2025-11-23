type TrieNode struct {
    children [2]*TrieNode
}

func maximizeXor(nums []int, queries [][]int) []int {
    sort.Ints(nums)
    n := len(queries)
    indexedQueries := make([][3]int, n)
    for i := 0; i < n; i++ {
        indexedQueries[i] = [3]int{queries[i][0], queries[i][1], i}
    }
    sort.Slice(indexedQueries, func(i, j int) bool {
        return indexedQueries[i][1] < indexedQueries[j][1]
    })

    res := make([]int, n)
    root := &TrieNode{}
    idx := 0
    m := len(nums)

    for _, query := range indexedQueries {
        x, limit, pos := query[0], query[1], query[2]
        for idx < m && nums[idx] <= limit {
            node := root
            for i := 30; i >= 0; i-- {
                bit := (nums[idx] >> i) & 1
                if node.children[bit] == nil {
                    node.children[bit] = &TrieNode{}
                }
                node = node.children[bit]
            }
            idx++
        }
        if idx == 0 {
            res[pos] = -1
            continue
        }
        node := root
        maxXor := 0
        for i := 30; i >= 0; i-- {
            bit := (x >> i) & 1
            toggledBit := 1 - bit
            if node.children[toggledBit] != nil {
                maxXor |= (1 << i)
                node = node.children[toggledBit]
            } else {
                node = node.children[bit]
            }
        }
        res[pos] = maxXor
    }
    return res
}