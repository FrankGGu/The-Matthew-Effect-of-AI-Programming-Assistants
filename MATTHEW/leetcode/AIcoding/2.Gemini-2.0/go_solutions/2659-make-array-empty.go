func makeArrayEmpty(nums []int) int64 {
    n := len(nums)
    idx := make([]int, n)
    for i := 0; i < n; i++ {
        idx[i] = i
    }
    sort.Slice(idx, func(i, j int) bool {
        if nums[idx[i]] != nums[idx[j]] {
            return nums[idx[i]] < nums[idx[j]]
        }
        return idx[i] < idx[j]
    })

    bit := NewBIT(n)
    ans := int64(0)
    for _, i := range idx {
        x := bit.Sum(i + 1)
        ans += int64(i + 1 - x)
        bit.Update(i + 1, 1)
    }
    return ans
}

type BIT struct {
    tree []int
    n    int
}

func NewBIT(n int) *BIT {
    return &BIT{
        tree: make([]int, n+1),
        n:    n,
    }
}

func (b *BIT) Update(i int, val int) {
    for i <= b.n {
        b.tree[i] += val
        i += i & -i
    }
}

func (b *BIT) Sum(i int) int {
    sum := 0
    for i > 0 {
        sum += b.tree[i]
        i -= i & -i
    }
    return sum
}
import "sort"