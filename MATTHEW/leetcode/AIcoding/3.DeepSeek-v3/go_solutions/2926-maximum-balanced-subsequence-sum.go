type FenwickTree struct {
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{
        tree: make([]int, size+1),
    }
}

func (ft *FenwickTree) update(index int, val int) {
    for index < len(ft.tree) {
        if ft.tree[index] < val {
            ft.tree[index] = val
        }
        index += index & -index
    }
}

func (ft *FenwickTree) query(index int) int {
    res := -1 << 31
    for index > 0 {
        if res < ft.tree[index] {
            res = ft.tree[index]
        }
        index -= index & -index
    }
    return res
}

func maxBalancedSubsequenceSum(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    uniqueSorted := make([]int, n)
    for i := 0; i < n; i++ {
        uniqueSorted[i] = nums[i] - i
    }

    sorted := make([]int, n)
    copy(sorted, uniqueSorted)
    sort.Ints(sorted)

    rank := make(map[int]int)
    r := 1
    for _, num := range sorted {
        if _, exists := rank[num]; !exists {
            rank[num] = r
            r++
        }
    }

    ft := NewFenwickTree(len(rank))
    maxSum := -1 << 31

    for i := 0; i < n; i++ {
        key := uniqueSorted[i]
        rk := rank[key]
        currentMax := ft.query(rk)
        if currentMax < 0 {
            currentMax = 0
        }
        currentSum := currentMax + nums[i]
        if currentSum > maxSum {
            maxSum = currentSum
        }
        ft.update(rk, currentSum)
    }

    return int64(maxSum)
}