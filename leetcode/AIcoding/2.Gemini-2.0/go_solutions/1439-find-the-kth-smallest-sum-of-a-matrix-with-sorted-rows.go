import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kthSmallest(mat [][]int, k int) int {
	m := len(mat)
	n := len(mat[0])

	h := &IntHeap{0}
	heap.Init(h)

	visited := make(map[string]bool)
	visited["[0]"] = true

	for i := 0; i < min(k, m*n); i++ {
		currSum := heap.Pop(h).(int)

		indices := make([]int, m)
		key := "[0]"
		if i > 0 {
			for j := 0; j < m; j++ {
				if currSum > 0 {

					for l:=0; l<n; l++{
						tempIndices := make([]int, m)
						copy(tempIndices, indices)
						tempIndices[j] = l+1

						tempSum := 0
						for row := 0; row < m; row++ {
							tempSum += mat[row][tempIndices[row]-1]
						}

						tempKey := "["
						for idx := 0; idx < m; idx++ {
							tempKey += string(rune(tempIndices[idx]+'0'))
							if idx < m-1 {
								tempKey += ","
							}
						}
						tempKey += "]"

						if !visited[tempKey] {
							heap.Push(h, tempSum)
							visited[tempKey] = true
						}

					}
					break
				}
			}

		} else {
			for j := 0; j < m; j++ {
				tempIndices := make([]int, m)
				tempIndices[j] = 1

				tempSum := 0
				for row := 0; row < m; row++ {
					tempSum += mat[row][tempIndices[row]-1]
				}

				tempKey := "["
				for idx := 0; idx < m; idx++ {
					tempKey += string(rune(tempIndices[idx]+'0'))
					if idx < m-1 {
						tempKey += ","
					}
				}
				tempKey += "]"

				if !visited[tempKey] {
					heap.Push(h, tempSum)
					visited[tempKey] = true
				}

			}
		}

		if i == k-1 {
			return currSum
		}
	}

	return 0
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}