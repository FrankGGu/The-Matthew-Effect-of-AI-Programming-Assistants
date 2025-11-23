type FenwickTree struct {
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{
        tree: make([]int, size+1),
    }
}

func (ft *FenwickTree) Update(index, delta int) {
    for index < len(ft.tree) {
        ft.tree[index] += delta
        index += index & -index
    }
}

func (ft *FenwickTree) Query(index int) int {
    res := 0
    for index > 0 {
        res += ft.tree[index]
        index -= index & -index
    }
    return res
}

func createSortedArray(instructions []int) int {
    const mod = 1e9 + 7
    maxVal := 0
    for _, num := range instructions {
        if num > maxVal {
            maxVal = num
        }
    }
    ft := NewFenwickTree(maxVal)
    res := 0
    for i, num := range instructions {
        left := ft.Query(num - 1)
        right := i - ft.Query(num)
        res += min(left, right)
        res %= mod
        ft.Update(num, 1)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}