import (
	"strconv"
	"strings"
)

type TreeNode struct {
    Val int
    Left *TreeNode
    Right *TreeNode
}

type Codec struct {
}

func Constructor() Codec {
    return Codec{}
}

func (this *Codec) Serialize(root *TreeNode) string {
    var vals []string
    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            vals = append(vals, "#")
            return
        }
        vals = append(vals, strconv.Itoa(node.Val))
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)
    return strings.Join(vals, ",")
}

func (this *Codec) Deserialize(data string) *TreeNode {
    vals := strings.Split(data, ",")
    idx := 0
    var buildTree func() *TreeNode
    buildTree = func() *TreeNode {
        if idx >= len(vals) || vals[idx] == "#" {
            idx++
            return nil
        }
        val, _ := strconv.Atoi(vals[idx])
        idx++
        node := &TreeNode{Val: val}
        node.Left = buildTree()
        node.Right = buildTree()
        return node
    }
    return buildTree()
}