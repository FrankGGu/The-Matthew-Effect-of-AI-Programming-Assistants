type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func smallestMissingValue(root *TreeNode) []int {
    result := []int{}
    var dfs func(node *TreeNode) map[int]struct{}
    dfs = func(node *TreeNode) map[int]struct{} {
        if node == nil {
            return nil
        }
        leftValues := dfs(node.Left)
        rightValues := dfs(node.Right)

        values := make(map[int]struct{})
        for v := range leftValues {
            values[v] = struct{}{}
        }
        for v := range rightValues {
            values[v] = struct{}{}
        }
        values[node.Val] = struct{}{}

        smallestMissing := 1
        for {
            if _, found := values[smallestMissing]; !found {
                break
            }
            smallestMissing++
        }
        result = append(result, smallestMissing)
        return values
    }
    dfs(root)
    return result
}