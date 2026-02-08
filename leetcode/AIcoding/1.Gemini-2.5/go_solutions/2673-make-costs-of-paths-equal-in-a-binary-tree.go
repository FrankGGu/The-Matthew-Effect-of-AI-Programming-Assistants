import "math"

func minIncrements(n int, cost []int) int {
    totalIncrements := 0

    // Iterate from the last parent node up to the root (node 0).
    // The last parent node is at index (n/2 - 1).
    // Nodes from n