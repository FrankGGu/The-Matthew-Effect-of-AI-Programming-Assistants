package main

func closestMeetingNode(root *TreeNode, k int, x int) int {
    var (
        parent = make(map[int]*TreeNode)
        visited = make(map[int]bool)
        queue []*TreeNode
        result int = -1
        minDist int = 1<<31 - 1
    )

    var dfs func(*TreeNode, *TreeNode)
    dfs = func(node *TreeNode, p *TreeNode) {
        if node == nil {
            return
        }
        parent[node.Val] = p
        dfs(node.Left, node)
        dfs(node.Right, node)
    }

    dfs(root, nil)

    var bfs func(*TreeNode, int)
    bfs = func(node *TreeNode, dist int) {
        if node == nil || visited[node.Val] {
            return
        }
        visited[node.Val] = true
        if dist < minDist {
            minDist = dist
            result = node.Val
        } else if dist == minDist && node.Val < result {
            result = node.Val
        }
        if parent[node.Val] != nil {
            bfs(parent[node.Val], dist+1)
        }
        bfs(node.Left, dist+1)
        bfs(node.Right, dist+1)
    }

    bfs(root, 0)
    return result
}