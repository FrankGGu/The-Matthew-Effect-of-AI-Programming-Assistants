/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func distanceK(root *TreeNode, target *TreeNode, K int) []int {
    parent := make(map[*TreeNode]*TreeNode)
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Left != nil {
            parent[node.Left] = node
            dfs(node.Left)
        }
        if node.Right != nil {
            parent[node.Right] = node
            dfs(node.Right)
        }
    }
    dfs(root)

    queue := []*TreeNode{target}
    visited := make(map[*TreeNode]bool)
    visited[target] = true
    distance := 0
    for len(queue) > 0 {
        if distance == K {
            break
        }
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            if node.Left != nil && !visited[node.Left] {
                visited[node.Left] = true
                queue = append(queue, node.Left)
            }
            if node.Right != nil && !visited[node.Right] {
                visited[node.Right] = true
                queue = append(queue, node.Right)
            }
            if p, exists := parent[node]; exists && !visited[p] {
                visited[p] = true
                queue = append(queue, p)
            }
        }
        distance++
    }

    res := make([]int, 0, len(queue))
    for _, node := range queue {
        res = append(res, node.Val)
    }
    return res
}