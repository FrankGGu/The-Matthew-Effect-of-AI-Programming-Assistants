import (
	"sort"
)

func maxSumSubmatrix(matrix [][]int, k int) int {
	m, n := len(matrix), len(matrix[0])
	maxSum := -1 << 63

	for left := 0; left < n; left++ {
		rowSum := make([]int, m)
		for right := left; right < n; right++ {
			for i := 0; i < m; i++ {
				rowSum[i] += matrix[i][right]
			}

			sum := 0
			sortedSet := []int{0}
			for i := 0; i < m; i++ {
				sum += rowSum[i]
				it := sort.SearchInts(sortedSet, sum-k)
				if it < len(sortedSet) {
					maxSum = max(maxSum, sum-sortedSet[it])
				}
				it = sort.SearchInts(sortedSet, sum)
				sortedSet = insert(sortedSet, it, sum)
			}
		}
	}

	return maxSum
}

func insert(arr []int, index int, value int) []int {
	arr = append(arr, 0)
	copy(arr[index+1:], arr[index:])
	arr[index] = value
	return arr
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {}