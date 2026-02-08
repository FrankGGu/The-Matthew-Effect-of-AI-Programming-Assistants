func largestOverlap(img1 [][]int, img2 [][]int) int {
    n := len(img1)
    maxOverlap := 0

    for di := -n + 1; di < n; di++ {
        for dj := -n + 1; dj < n; dj++ {
            overlap := 0
            for i := 0; i < n; i++ {
                for j := 0; j < n; j++ {
                    ni, nj := i + di, j + dj
                    if ni >= 0 && ni < n && nj >= 0 && nj < n {
                        if img1[ni][nj] == 1 && img2[i][j] == 1 {
                            overlap++
                        }
                    }
                }
            }
            if overlap > maxOverlap {
                maxOverlap = overlap
            }
        }
    }

    return maxOverlap
}