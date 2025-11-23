package main


type Codec struct {
}

func Constructor() Codec {
    return Codec{}
}

func (c *Codec) serialize(root *TreeNode) string {
    var res []string
    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            res = append(res, "nil")
            return
        }
        res = append(res, strconv.Itoa(node.Val))
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)
    return strings.Join(res, ",")
}

func (c *Codec) deserialize(data string) *TreeNode {
    nodes := strings.Split(data, ",")
    var build func() *TreeNode
    build = func() *TreeNode {
        if nodes[0] == "nil" {
            nodes = nodes[1:]
            return nil
        }
        val, _ := strconv.Atoi(nodes[0])
        nodes = nodes[1:]
        return &TreeNode{
            Val:   val,
            Left:  build(),
            Right: build(),
        }
    }
    return build()
}