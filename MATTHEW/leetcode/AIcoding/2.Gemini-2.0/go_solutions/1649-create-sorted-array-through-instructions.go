func createSortedArray(instructions []int) int {
	n := len(instructions)
	arr := make([]int, 0, n)
	cost := 0
	mod := 1000000007
	bit := NewBIT(100001)

	for _, num := range instructions {
		less := bit.Query(num - 1)
		greater := len(arr) - bit.Query(num)
		cost += min(less, greater)
		cost %= mod
		arr = append(arr, num)
		bit.Update(num, 1)
	}

	return cost
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

type BIT struct {
	tree []int
	size int
}

func NewBIT(size int) *BIT {
	return &BIT{
		tree: make([]int, size+1),
		size: size,
	}
}

func (bit *BIT) Update(index, val int) {
	index++
	for index <= bit.size {
		bit.tree[index] += val
		index += index & -index
	}
}

func (bit *BIT) Query(index int) int {
	index++
	sum := 0
	for index > 0 {
		sum += bit.tree[index]
		index -= index & -index
	}
	return sum
}