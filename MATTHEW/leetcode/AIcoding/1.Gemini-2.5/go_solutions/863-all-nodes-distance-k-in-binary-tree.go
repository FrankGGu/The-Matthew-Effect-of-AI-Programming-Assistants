func distanceK(root *TreeNode, target *TreeNode, k int) []int {
    parentMap := make(map[*TreeNode]*TreeNode)

    var buildParentMap func(*TreeNode, *TreeNode)
    buildParentMap = func(node *TreeNode, parent *TreeNode) {
        if node == nil {
            return
        }
        parentMap[node] = parent
        buildParentMap(node.Left, node)
        buildParentMap(node.Right, node)
    }

    buildParentMap(root, nil)

    queue := []*TreeNode{target}
    visited := make(map[*TreeNode]bool)
    visited[target] = true
    distance := 0
    result := []int{}

    for len(queue) > 0 && distance <= k {
        levelSize := len(queue)

        if distance == k {
            for _, node := range queue {
                result = append(result, node.Val)
            }
            return result
        }

        for i := 0; i < levelSize; i++ {
            curr := queue[0]
            queue = queue[1:]

            if curr.Left != nil && !visited[curr.Left] {
                visited[curr.Left] = true
                queue = append(queue, curr.Left)
            }
            if curr.Right != nil && !visited[curr.Right] {
                visited[curr.Right] = true
                queue = append(queue, curr.Right)
            }
            if parent, ok := parentMap[curr]; ok && parent != nil && !visited[parent] {
                visited[parent] = true
                queue = append(queue, parent)
            }
        }
        distance++
    }

    return result
}