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

func (ft *FenwickTree) update(index int, delta int) {
    for index <= ft.size {
        ft.tree[index] += delta
        index += index & -index
    }
}

func (ft *FenwickTree) query(index int) int {
    res := 0
    for index > 0 {
        res += ft.tree[index]
        index -= index & -index
    }
    return res
}

func resultArray(nums []int) []int {
    n := len(nums)
    sorted := make([]int, n)
    copy(sorted, nums)
    sort.Ints(sorted)
    rank := make(map[int]int)
    for i, num := range sorted {
        rank[num] = i + 1
    }

    arr1 := []int{nums[0]}
    arr2 := []int{nums[1]}
    ft1 := NewFenwickTree(n)
    ft2 := NewFenwickTree(n)
    ft1.update(rank[nums[0]], 1)
    ft2.update(rank[nums[1]], 1)

    for i := 2; i < n; i++ {
        num := nums[i]
        r := rank[num]
        cnt1 := len(arr1) - ft1.query(r)
        cnt2 := len(arr2) - ft2.query(r)
        if cnt1 > cnt2 {
            arr1 = append(arr1, num)
            ft1.update(r, 1)
        } else if cnt1 < cnt2 {
            arr2 = append(arr2, num)
            ft2.update(r, 1)
        } else {
            if len(arr1) <= len(arr2) {
                arr1 = append(arr1, num)
                ft1.update(r, 1)
            } else {
                arr2 = append(arr2, num)
                ft2.update(r, 1)
            }
        }
    }

    return append(arr1, arr2...)
}