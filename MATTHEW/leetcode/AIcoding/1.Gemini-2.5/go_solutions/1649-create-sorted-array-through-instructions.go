type FenwickTree struct {
	data []int
	size int
}

func NewFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		data: make([]int, size+1),
		size: size,
	}
}

func (ft *FenwickTree) Update(idx, val int) {
	for idx <= ft.size {
		ft.data[idx] += val
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) Query(idx int) int {
	sum := 0
	for idx > 0 {
		sum += ft.data[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func createSortedArray(instructions []int) int {
	const fixedMaxVal = 100000 
	ft := NewFenwickTree(fixedMaxVal)

	totalCost := 0

	for i, num := range instructions {
		countLess := ft.Query(num - 1)

		totalInserted := i

		countGreater := totalInserted - ft.Query(num)

		cost := countLess
		if countGreater < cost {
			cost = countGreater
		}
		totalCost += cost

		ft.Update(num, 1)
	}

	return totalCost
}