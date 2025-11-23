type SegmentTree struct {
    left, right *SegmentTree
    l, r        int
    sum         int
    flip        bool
}

func (st *SegmentTree) pushDown() {
    if st.l == st.r {
        return
    }
    if st.left == nil {
        mid := st.l + (st.r-st.l)/2
        st.left = &SegmentTree{l: st.l, r: mid}
        st.right = &SegmentTree{l: mid + 1, r: st.r}
    }
    if st.flip {
        st.left.sum = (st.left.r - st.left.l + 1) - st.left.sum
        st.left.flip = !st.left.flip
        st.right.sum = (st.right.r - st.right.l + 1) - st.right.sum
        st.right.flip = !st.right.flip
        st.flip = false
    }
}

func (st *SegmentTree) updateRange(l, r int) {
    if st.r < l || st.l > r {
        return
    }
    if l <= st.l && st.r <= r {
        st.sum = (st.r - st.l + 1) - st.sum
        st.flip = !st.flip
        return
    }
    st.pushDown()
    st.left.updateRange(l, r)
    st.right.updateRange(l, r)
    st.sum = st.left.sum + st.right.sum
}

func (st *SegmentTree) queryRange(l, r int) int {
    if st.r < l || st.l > r {
        return 0
    }
    if l <= st.l && st.r <= r {
        return st.sum
    }
    st.pushDown()
    return st.left.queryRange(l, r) + st.right.queryRange(l, r)
}

func handleQuery(nums1 []int, nums2 []int, queries [][]int) []int64 {
    n := len(nums1)
    root := &SegmentTree{l: 0, r: n - 1}
    for i := 0; i < n; i++ {
        if nums1[i] == 1 {
            root.updateRange(i, i)
        }
    }
    sum := int64(0)
    for _, num := range nums2 {
        sum += int64(num)
    }
    var res []int64
    for _, q := range queries {
        if q[0] == 1 {
            l, r := q[1], q[2]
            root.updateRange(l, r)
        } else if q[0] == 2 {
            p := q[1]
            cnt := root.queryRange(0, n-1)
            sum += int64(p) * int64(cnt)
        } else if q[0] == 3 {
            res = append(res, sum)
        }
    }
    return res
}