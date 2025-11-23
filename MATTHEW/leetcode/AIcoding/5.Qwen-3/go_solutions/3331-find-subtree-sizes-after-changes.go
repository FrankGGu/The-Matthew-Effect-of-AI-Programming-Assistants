package main


func findSubtreeSizes(parents []int, s string) []int {
    n := len(s)
    tree := make([]*TreeNode, n)
    for i := 0; i < n; i++ {
        tree[i] = &TreeNode{Val: int(s[i] - 'a')}
    }
    for i := 1; i < n; i++ {
        p := parents[i]
        if tree[p].Left == nil {
            tree[p].Left = tree[i]
        } else {
            tree[p].Right = tree[i]
        }
    }

    result := make([]int, n)
    var dfs func(*TreeNode) map[byte]int
    dfs = func(node *TreeNode) map[byte]int {
        if node == nil {
            return make(map[byte]int)
        }
        count := make(map[byte]int)
        left := dfs(node.Left)
        right := dfs(node.Right)
        for k, v := range left {
            count[k] += v
        }
        for k, v := range right {
            count[k] += v
        }
        count[byte(node.Val)]++
        result[node.Val] = len(count)
        return count
    }
    dfs(tree[0])
    return result
}