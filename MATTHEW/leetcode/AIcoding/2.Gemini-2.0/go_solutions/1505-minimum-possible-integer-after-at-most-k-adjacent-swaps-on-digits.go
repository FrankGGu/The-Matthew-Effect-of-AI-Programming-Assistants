import (
	"fmt"
	"strconv"
)

func minInteger(num string, k int) string {
	n := len(num)
	nums := make([]int, n)
	for i := 0; i < n; i++ {
		nums[i], _ = strconv.Atoi(string(num[i]))
	}

	res := make([]byte, 0)
	bit := NewBIT(n + 1)

	for i := 1; i <= n; i++ {
		bit.Update(i, 1)
	}

	for i := 0; i < n; i++ {
		minIdx := -1
		minVal := 10

		for j := 0; j < n; j++ {
			if nums[j] != -1 {
				swaps := j - bit.Query(j+1)
				if swaps <= k && nums[j] < minVal {
					minVal = nums[j]
					minIdx = j
				}
			}
		}

		swaps := minIdx - bit.Query(minIdx+1)
		k -= swaps
		res = append(res, byte(minVal+'0'))
		nums[minIdx] = -1
		bit.Update(minIdx+1, -1)
	}

	return string(res)
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

func (b *BIT) Update(i, val int) {
	for i <= b.n {
		b.tree[i] += val
		i += i & -i
	}
}

func (b *BIT) Query(i int) int {
	sum := 0
	for i > 0 {
		sum += b.tree[i]
		i -= i & -i
	}
	return sum
}