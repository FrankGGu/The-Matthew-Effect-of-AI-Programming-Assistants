type ThroneInheritance struct {
    king  string
    edges map[string][]string
    dead  map[string]bool
}

func Constructor(kingName string) ThroneInheritance {
    return ThroneInheritance{
        king:  kingName,
        edges: make(map[string][]string),
        dead:  make(map[string]bool),
    }
}

func (this *ThroneInheritance) Birth(parentName string, childName string) {
    this.edges[parentName] = append(this.edges[parentName], childName)
}

func (this *ThroneInheritance) Death(name string) {
    this.dead[name] = true
}

func (this *ThroneInheritance) GetInheritanceOrder() []string {
    order := []string{}
    var dfs func(string)
    dfs = func(name string) {
        if !this.dead[name] {
            order = append(order, name)
        }
        for _, child := range this.edges[name] {
            dfs(child)
        }
    }
    dfs(this.king)
    return order
}