type QueueEntry struct {
    node *TreeNode
    index int
}

func widthOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }

    maxWidth := 0

    queue := []QueueEntry{{node: root, index: 1}}

    for len(queue) > 0 {
        levelSize := len(queue)

        firstIndexOnLevel := queue[0].index

        minNormalizedIndex := -1
        maxNormalizedIndex := -1

        for i := 0; i < levelSize; i++ {
            currEntry := queue[0]
            queue = queue[1:]

            currNode := currEntry.node
            currOriginalIndex := currEntry.index

            normalizedIndex := currOriginalIndex - firstIndexOnLevel

            if minNormalizedIndex == -1 {
                minNormalizedIndex = normalizedIndex
            }
            maxNormalizedIndex = normalizedIndex

            if currNode.Left != nil {
                queue = append(queue, QueueEntry{node: currNode.Left, index: 2 * normalizedIndex})
            }
            if currNode.Right != nil {
                queue = append(queue, QueueEntry{node: currNode.Right, index: 2 * normalizedIndex + 1})
            }
        }

        currentLevelWidth := maxNormalizedIndex - minNormalizedIndex + 1

        if currentLevelWidth > maxWidth {
            maxWidth = currentLevelWidth
        }
    }

    return maxWidth
}