import "sort"

func maxSumSubmatrix(matrix [][]int, k int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    maxSum := math.MinInt32

    for left := 0; left < cols; left++ {
        sums := make([]int, rows)

        for right := left; right < cols; right++ {
            for i := 0; i < rows; i++ {
                sums[i] += matrix[i][right]
            }

            set := make([]int, 0)
            currentSum := 0
            set = append(set, 0)

            for _, sum := range sums {
                currentSum += sum
                idx := sort.Search(len(set), func(i int) bool {
                    return set[i] >= currentSum-k
                })
                if idx < len(set) {
                    maxSum = max(maxSum, currentSum-set[idx])
                }
                sort.Insert(&set, currentSum)
            }
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}