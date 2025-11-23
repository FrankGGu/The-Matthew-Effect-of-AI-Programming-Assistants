package main


func allPossibleFBT(n int) []*TreeNode {
    memo := map[int][]*TreeNode{}
    return helper(n, memo)
}

func helper(n int, memo map[int][]*TreeNode) []*TreeNode {
    if n == 0 {
        return []*TreeNode{}
    }
    if n == 1 {
        return []*TreeNode{&TreeNode{}}
    }
    if trees, ok := memo[n]; ok {
        return trees
    }
    result := []*TreeNode{}
    for i := 1; i < n; i += 2 {
        left := helper(i, memo)
        right := helper(n-1-i, memo)
        for _, l := range left {
            for _, r := range right {
                root := &TreeNode{Val: 0, Left: l, Right: r}
                result = append(result, root)
            }
        }
    }
    memo[n] = result
    return result
}