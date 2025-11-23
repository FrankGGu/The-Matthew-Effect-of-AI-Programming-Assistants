import "math"

var minSquares int
var N, M int // Global variables to store dimensions for convenience in recursive calls

func tilingRectangle(n int, m int) int {
    N = n
    M = m

    // Normalize dimensions to ensure N <= M, as the problem is symmetric
    // This helps in potentially reducing redundant