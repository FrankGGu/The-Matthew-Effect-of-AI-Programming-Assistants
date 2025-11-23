type FenwickTree struct {
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{make([]int, size+1)}
}

func (ft *FenwickTree) Update(index, val int) {
    for index < len(ft.tree) {
        if ft.tree[index] < val {
            ft.tree[index] = val
        }
        index += index & -index
    }
}

func (ft *FenwickTree) Query(index int) int {
    res := -1
    for index > 0 {
        if res < ft.tree[index] {
            res = ft.tree[index]
        }
        index -= index & -index
    }
    return res
}

func maximumSumQueries(nums1 []int, nums2 []int, queries [][]int) []int {
    n := len(nums1)
    m := len(queries)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{nums1[i], nums2[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0] > pairs[j][0]
    })

    sortedY := make([]int, 0)
    for _, pair := range pairs {
        sortedY = append(sortedY, pair[1])
    }
    for _, query := range queries {
        sortedY = append(sortedY, query[1])
    }
    sort.Ints(sortedY)
    yToRank := make(map[int]int)
    rank := 1
    for i := 0; i < len(sortedY); i++ {
        if i == 0 || sortedY[i] != sortedY[i-1] {
            yToRank[sortedY[i]] = rank
            rank++
        }
    }

    qIndices := make([]int, m)
    for i := 0; i < m; i++ {
        qIndices[i] = i
    }
    sort.Slice(qIndices, func(i, j int) bool {
        return queries[qIndices[i]][0] > queries[qIndices[j]][0]
    })

    ft := NewFenwickTree(rank)
    res := make([]int, m)
    ptr := 0
    for _, qIdx := range qIndices {
        x, y := queries[qIdx][0], queries[qIdx][1]
        for ptr < n && pairs[ptr][0] >= x {
            yVal := pairs[ptr][1]
            sum := pairs[ptr][0] + pairs[ptr][1]
            rankY := yToRank[yVal]
            ft.Update(rankY, sum)
            ptr++
        }
        rankY := yToRank[y]
        maxSum := ft.Query(rank)
        res[qIdx] = maxSum
    }
    return res
}