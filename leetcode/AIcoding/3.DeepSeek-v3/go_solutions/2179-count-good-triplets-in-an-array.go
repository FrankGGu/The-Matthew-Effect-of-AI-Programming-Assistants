type FenwickTree struct {
    size int
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{
        size: size,
        tree: make([]int, size+1),
    }
}

func (ft *FenwickTree) Update(index int, delta int) {
    for index <= ft.size {
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

func goodTriplets(nums1 []int, nums2 []int) int64 {
    n := len(nums1)
    pos := make([]int, n)
    for i, num := range nums2 {
        pos[num] = i + 1
    }

    A := make([]int, n)
    for i, num := range nums1 {
        A[i] = pos[num]
    }

    left := make([]int, n)
    right := make([]int, n)

    ft := NewFenwickTree(n)
    for i := 0; i < n; i++ {
        left[i] = ft.Query(A[i] - 1)
        ft.Update(A[i], 1)
    }

    ft = NewFenwickTree(n)
    for i := n - 1; i >= 0; i-- {
        right[i] = ft.Query(n) - ft.Query(A[i])
        ft.Update(A[i], 1)
    }

    var res int64
    for i := 0; i < n; i++ {
        res += int64(left[i]) * int64(right[i])
    }
    return res
}