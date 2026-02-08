type BookMyShow struct {
    n, m int
    tree *SegmentTree
}

func Constructor(n int, m int) BookMyShow {
    tree := NewSegmentTree(n, m)
    return BookMyShow{n: n, m: m, tree: tree}
}

func (this *BookMyShow) Gather(k int, maxRow int) []int {
    row := this.tree.queryGather(0, 0, this.n-1, k, maxRow)
    if row == -1 {
        return []int{}
    }
    seats := this.tree.getSeats(row)
    this.tree.updateRange(row, row, k)
    return []int{row, seats - k}
}

func (this *BookMyShow) Scatter(k int, maxRow int) bool {
    if this.tree.querySum(0, 0, this.n-1, 0, maxRow) < k {
        return false
    }
    i := 0
    for k > 0 {
        seats := this.tree.getSeats(i)
        use := min(seats, k)
        this.tree.updateRange(i, i, use)
        k -= use
        i++
    }
    return true
}

type SegmentTree struct {
    n, m int
    sum  []int
    min  []int
}

func NewSegmentTree(n, m int) *SegmentTree {
    size := 1
    for size < n {
        size <<= 1
    }
    sum := make([]int, 2*size)
    min := make([]int, 2*size)
    for i := 0; i < n; i++ {
        sum[size+i] = m
        min[size+i] = m
    }
    for i := size - 1; i > 0; i-- {
        sum[i] = sum[2*i] + sum[2*i+1]
        min[i] = minVal(min[2*i], min[2*i+1])
    }
    return &SegmentTree{
        n:   n,
        m:   m,
        sum: sum,
        min: min,
    }
}

func (st *SegmentTree) queryGather(pos, l, r, k, maxRow int) int {
    if st.min[pos] < k || l > maxRow {
        return -1
    }
    if l == r {
        return l
    }
    mid := (l + r) / 2
    res := st.queryGather(2*pos, l, mid, k, maxRow)
    if res != -1 {
        return res
    }
    return st.queryGather(2*pos+1, mid+1, r, k, maxRow)
}

func (st *SegmentTree) querySum(pos, l, r, ql, qr int) int {
    if qr < l || ql > r {
        return 0
    }
    if ql <= l && r <= qr {
        return st.sum[pos]
    }
    mid := (l + r) / 2
    return st.querySum(2*pos, l, mid, ql, qr) + st.querySum(2*pos+1, mid+1, r, ql, qr)
}

func (st *SegmentTree) updateRange(pos, l, r, ql, qr, val int) {
    if qr < l || ql > r {
        return
    }
    if l == r {
        st.sum[pos] -= val
        st.min[pos] -= val
        return
    }
    mid := (l + r) / 2
    st.updateRange(2*pos, l, mid, ql, qr, val)
    st.updateRange(2*pos+1, mid+1, r, ql, qr, val)
    st.sum[pos] = st.sum[2*pos] + st.sum[2*pos+1]
    st.min[pos] = minVal(st.min[2*pos], st.min[2*pos+1])
}

func (st *SegmentTree) getSeats(row int) int {
    pos := 1
    l, r := 0, st.n-1
    for l != r {
        mid := (l + r) / 2
        if row <= mid {
            pos = 2 * pos
            r = mid
        } else {
            pos = 2*pos + 1
            l = mid + 1
        }
    }
    return st.m - st.min[pos]
}

func minVal(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}