func validSquare(p1 []int, p2 []int, p3 []int, p4 []int) bool {
    // Helper function to calculate squared Euclidean distance
    // This avoids floating-point issues and is sufficient for comparison.
    squaredDistance := func(point1, point2 []int) int {
        dx :=