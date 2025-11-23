func validateBinaryTreeNodes(n int, leftChild []int, rightChild []int) bool {
    indegree := make([]int, n)
    for i := 0; i < n; i++ {
        if leftChild[i] != -1 {
            indegree[leftChild[i]]++
        }
        if rightChild[i] != -1 {
            indegree[rightChild[i]]++
        }
    }

    rootCount := 0
    for i := 0; i < n; i++ {
        if indegree[i] == 0 {
            rootCount++
        } else if indegree[i] > 1 {
            return false
        }
    }

    return rootCount == 1
}