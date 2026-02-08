type SegmentTree struct {
    start, end, max int
    left, right     *SegmentTree
}

func (st *SegmentTree) update(index, val int) {
    if st.start == st.end {
        st.max = val
        return
    }
    mid := (st.start + st.end) / 2
    if index <= mid {
        st.left.update(index, val)
    } else {
        st.right.update(index, val)
    }
    st.max = max(st.left.max, st.right.max)
}

func (st *SegmentTree) query(start, end int) int {
    if start > end {
        return 0
    }
    if st.start == start && st.end == end {
        return st.max
    }
    mid := (st.start + st.end) / 2
    if end <= mid {
        return st.left.query(start, end)
    } else if start > mid {
        return st.right.query(start, end)
    } else {
        return max(st.left.query(start, mid), st.right.query(mid+1, end))
    }
}

func build(start, end int) *SegmentTree {
    st := &SegmentTree{start: start, end: end, max: 0}
    if start == end {
        return st
    }
    mid := (start + end) / 2
    st.left = build(start, mid)
    st.right = build(mid+1, end)
    return st
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func lengthOfLIS(nums []int, k int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }
    st := build(1, maxNum)
    res := 0
    for _, num := range nums {
        left := max(1, num-k)
        right := num - 1
        curr := st.query(left, right) + 1
        if curr > res {
            res = curr
        }
        st.update(num, curr)
    }
    return res
}