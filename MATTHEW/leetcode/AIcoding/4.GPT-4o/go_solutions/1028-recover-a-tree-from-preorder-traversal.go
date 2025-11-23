type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func recoverFromPreorder(S string) *TreeNode {
    stack := []*TreeNode{}
    i := 0
    for i < len(S) {
        level := 0
        for i < len(S) && S[i] == '-' {
            level++
            i++
        }
        val := 0
        for i < len(S) && S[i] >= '0' && S[i] <= '9' {
            val = val*10 + int(S[i]-'0')
            i++
        }
        node := &TreeNode{Val: val}
        if level == len(stack) {
            if len(stack) > 0 {
                stack[len(stack)-1].Left = node
            }
        } else {
            stack = stack[:level]
            stack[level-1].Right = node
        }
        stack = append(stack, node)
    }
    return stack[0]
}