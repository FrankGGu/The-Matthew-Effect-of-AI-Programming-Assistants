type FenwickTree struct {
    tree []int
}

func NewFenwickTree(size int) *FenwickTree {
    return &FenwickTree{
        tree: make([]int, size+1),
    }
}

func (ft *FenwickTree) Update(index int, delta int) {
    for index < len(ft.tree) {
        ft.tree[index] += delta
        index += index & -index
    }
}

func (ft *FenwickTree) Query(index int) int {
    sum := 0
    for index > 0 {
        sum += ft.tree[index]
        index -= index & -index
    }
    return sum
}

func countSmaller(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }

    uniqueNums := make([]int, len(nums))
    copy(uniqueNums, nums)
    sort.Ints(uniqueNums)
    rank := make(map[int]int)
    r := 1
    for i := 0; i < len(uniqueNums); i++ {
        if i > 0 && uniqueNums[i] == uniqueNums[i-1] {
            continue
        }
        rank[uniqueNums[i]] = r
        r++
    }

    ft := NewFenwickTree(len(rank))
    res := make([]int, len(nums))
    for i := len(nums) - 1; i >= 0; i-- {
        r := rank[nums[i]]
        res[i] = ft.Query(r - 1)
        ft.Update(r, 1)
    }
    return res
}