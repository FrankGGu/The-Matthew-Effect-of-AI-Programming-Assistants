func recordDecoration(root *TreeNode) []int {
    res := []int{}
    q := []*TreeNode{root}
    for len(q) > 0 {
        levelSize := len(q)
        temp := []int{}
        for i := 0; i < levelSize; i++ {
            node := q[0]
            q = q[1:]
            temp = append(temp, node.Val)
            if node.Left != nil {
                q = append(q, node.Left)
            }
            if node.Right != nil {
                q = append(q, node.Right)
            }
        }
        if len(res)%2 == 0 {
            res = append(res, temp...)
        } else {
            for i, j := 0, len(temp)-1; i < j; i, j = i+1, j-1 {
                temp[i], temp[j] = temp[j], temp[i]
            }
            res = append(res, temp...)
        }
    }
    return res
}