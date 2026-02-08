/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func distanceK(root *TreeNode, target *TreeNode, K int) []int {
    graph := make(map[*TreeNode][]*TreeNode)
    var buildGraph func(node *TreeNode)
    buildGraph = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Left != nil {
            graph[node] = append(graph[node], node.Left)
            graph[node.Left] = append(graph[node.Left], node)
            buildGraph(node.Left)
        }
        if node.Right != nil {
            graph[node] = append(graph[node], node.Right)
            graph[node.Right] = append(graph[node.Right], node)
            buildGraph(node.Right)
        }
    }
    buildGraph(root)

    result := []int{}
    visited := make(map[*TreeNode]bool)
    var bfs func(node *TreeNode, depth int)
    bfs = func(node *TreeNode, depth int) {
        if node == nil || visited[node] {
            return
        }
        visited[node] = true
        if depth == K {
            result = append(result, node.Val)
            return
        }
        for _, neighbor := range graph[node] {
            bfs(neighbor, depth+1)
        }
    }
    bfs(target, 0)
    return result
}