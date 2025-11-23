type ThroneInheritance struct {
	kingName string
	graph    map[string][]string
	dead     map[string]bool
}

func Constructor(kingName string) ThroneInheritance {
	return ThroneInheritance{
		kingName: kingName,
		graph:    make(map[string][]string),
		dead:     make(map[string]bool),
	}
}

func (this *ThroneInheritance) Birth(parentName string, childName string) {
	this.graph[parentName] = append(this.graph[parentName], childName)
}

func (this *ThroneInheritance) Death(name string) {
	this.dead[name] = true
}

func (this *ThroneInheritance) GetInheritanceOrder() []string {
	res := []string{}
	var dfs func(name string)
	dfs = func(name string) {
		if !this.dead[name] {
			res = append(res, name)
		}
		for _, child := range this.graph[name] {
			dfs(child)
		}
	}
	dfs(this.kingName)
	return res
}