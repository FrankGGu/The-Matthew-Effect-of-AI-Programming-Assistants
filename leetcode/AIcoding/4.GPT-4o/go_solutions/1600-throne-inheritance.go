type TreeNode struct {
    Name     string
    Children []*TreeNode
}

type ThroneInheritance struct {
    root *TreeNode
    dead  map[string]bool
}

func Constructor(knight string) ThroneInheritance {
    return ThroneInheritance{
        root: &TreeNode{Name: knight, Children: []*TreeNode{}},
        dead:  make(map[string]bool),
    }
}

func (this *ThroneInheritance) Birth(parentName string, childName string) {
    var parent *TreeNode
    var findParent func(node *TreeNode)
    findParent = func(node *TreeNode) {
        if node.Name == parentName {
            parent = node
            return
        }
        for _, child := range node.Children {
            findParent(child)
        }
    }
    findParent(this.root)
    if parent != nil {
        parent.Children = append(parent.Children, &TreeNode{Name: childName, Children: []*TreeNode{}})
    }
}

func (this *ThroneInheritance) Death(name string) {
    this.dead[name] = true
}

func (this *ThroneInheritance) GetInheritanceOrder() []string {
    order := []string{}
    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if !this.dead[node.Name] {
            order = append(order, node.Name)
        }
        for _, child := range node.Children {
            dfs(child)
        }
    }
    dfs(this.root)
    return order
}