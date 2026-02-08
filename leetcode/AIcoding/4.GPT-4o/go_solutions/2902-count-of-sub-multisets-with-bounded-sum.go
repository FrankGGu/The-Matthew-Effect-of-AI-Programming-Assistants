func countSubmatricesWithSum(matrix [][]int, target int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    count := 0

    for left := 0; left < cols; left++ {
        sums := make([]int, rows)
        for right := left; right < cols; right++ {
            for i := 0; i < rows; i++ {
                sums[i] += matrix[i][right]
            }
            count += countSubarraysWithSum(sums, target)
        }
    }

    return count
}

func countSubarraysWithSum(sums []int, target int) int {
    count := 0
    prefixSumCount := map[int]int{0: 1}
    currentSum := 0

    for _, sum := range sums {
        currentSum += sum
        if _, ok := prefixSumCount[currentSum-target]; ok {
            count += prefixSumCount[currentSum-target]
        }
        prefixSumCount[currentSum]++
    }

    return count
}