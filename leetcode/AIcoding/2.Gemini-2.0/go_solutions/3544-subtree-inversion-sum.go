func subtreeInversionSum(root *TreeNode) []int {
    res := []int{}
    var dfs func(*TreeNode) []int
    dfs = func(node *TreeNode) []int {
        if node == nil {
            return []int{}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        arr := append(left, right...)
        arr = append(arr, node.Val)
        inv := 0
        for i := 0; i < len(arr); i++ {
            for j := i + 1; j < len(arr); j++ {
                if arr[i] > arr[j] {
                    inv++
                }
            }
        }
        res = append(res, inv)
        return arr
    }
    dfs(root)
    return res
}