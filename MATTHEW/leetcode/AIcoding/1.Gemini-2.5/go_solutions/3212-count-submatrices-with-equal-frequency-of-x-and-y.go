package main

type FenwickTree struct {
	size int
	tree []int
}

func newFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		size: size,
		tree: make([]int, size+1), // 1-indexed
	}
}

func (ft *FenwickTree) update(idx, val int) {
	idx++ // Convert to 1-indexed
	for idx <= ft.size {
		ft.tree[idx] += val
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) query(idx int) int {
	idx++ // Convert to 1-indexed
	sum := 0
	for idx > 0 {
		sum += ft.tree[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func countSubmatrices(grid [][]byte) int {
	m := len(grid)
	n := len(grid[0])

	totalCount := 0

	for r1 := 0; r1 < m; r1++ {
		currentColDiffSum := make([]int, n)
		currentColXSum := make([]int, n)

		for r2 := r1; r2 < m; r2++ {
			for c := 0; c < n; c++ {
				if grid[r2][c] == 'X' {
					currentColDiffSum[c]++
					currentColXSum[c]++
				} else if grid[r2][c] == 'Y' {
					currentColDiffSum[c]--
				}
			}

			prefixDiff := make([]int, n+1)
			prefixX := make([]int, n+1)

			for k := 0; k < n; k++ {
				prefixDiff[k+1] = prefixDiff[k] + currentColDiffSum[k]
				prefixX[k+1] = prefixX[k] + currentColXSum[k]
			}

			diffToFT := make(map[int]*FenwickTree)

			ftZero := newFenwickTree(n + 1)
			ftZero.update(0, 1)
			diffToFT[0] = ftZero

			for j := 1; j <= n; j++ {
				currentDiff := prefixDiff[j]
				currentX := prefixX[j]

				if ft, ok := diffToFT[currentDiff]; ok {
					totalCount += ft.query(currentX - 1)
				}

				if _, ok := diffToFT[currentDiff]; !ok {
					diffToFT[currentDiff] = newFenwickTree(n + 1)
				}
				diffToFT[currentDiff].update(currentX, 1)
			}
		}
	}

	return totalCount
}