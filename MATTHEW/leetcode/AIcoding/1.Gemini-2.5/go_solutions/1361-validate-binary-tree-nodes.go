func validateBinaryTreeNodes(n int, leftChild []int, rightChild []int) bool {
    inDegree := make([]int, n)

    // Step 1: Calculate in-degrees for all nodes
    // Also, check if any node has more than one parent.
    for i := 0; i < n; i++ {