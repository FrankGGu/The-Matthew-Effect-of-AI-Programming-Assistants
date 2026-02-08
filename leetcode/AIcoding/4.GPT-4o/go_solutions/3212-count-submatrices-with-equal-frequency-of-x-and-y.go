func countSubmatrices(matrix [][]int, x int, y int) int {
    m, n := len(matrix), len(matrix[0])
    count := 0

    for r1 := 0; r1 < m; r1++ {
        for r2 := r1; r2 < m; r2++ {
            freq := make(map[int]int)
            for c := 0; c < n; c++ {
                if r1 == 0 {
                    freq[matrix[r2][c]]++
                } else {
                    freq[matrix[r2][c]] -= matrix[r1-1][c] > 0
                    freq[matrix[r2][c]] += matrix[r2][c] > 0
                }
                if freq[x] == freq[y] && freq[x] > 0 {
                    count++
                }
            }
        }
    }

    return count
}