type FenwickTree struct {
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{
        tree: make([]int, size+1),
    }
}

func (ft *FenwickTree) update(index, delta int) {
    for index < len(ft.tree) {
        ft.tree[index] += delta
        index += index & -index
    }
}

func (ft *FenwickTree) query(index int) int {
    sum := 0
    for index > 0 {
        sum += ft.tree[index]
        index -= index & -index
    }
    return sum
}

func bonus(n int, leadership [][]int, operations [][]int) []int {
    adj := make([][]int, n+1)
    for _, edge := range leadership {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
    }

    in := make([]int, n+1)
    out := make([]int, n+1)
    time := 0
    var dfs func(int)
    dfs = func(u int) {
        time++
        in[u] = time
        for _, v := range adj[u] {
            dfs(v)
        }
        out[u] = time
    }
    dfs(1)

    ft := NewFenwickTree(n)
    res := []int{}
    for _, op := range operations {
        if op[0] == 1 {
            u := op[1]
            coins := op[2]
            ft.update(in[u], coins)
        } else if op[0] == 2 {
            u := op[1]
            coins := op[2]
            ft.update(in[u], coins)
            if out[u] > in[u] {
                ft.update(out[u]+1, -coins)
            }
        } else if op[0] == 3 {
            u := op[1]
            sum := ft.query(out[u]) - ft.query(in[u]-1)
            res = append(res, sum)
        }
    }
    return res
}