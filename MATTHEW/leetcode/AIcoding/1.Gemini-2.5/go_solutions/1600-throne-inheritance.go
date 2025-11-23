type ThroneInheritance struct {
	kingName string
	children map[string][]string
	dead     map[string]bool
}

func Constructor(kingName string) ThroneInheritance {
	return ThroneInheritance{
		kingName: kingName,
		children: make(map[string][]string),
		dead:     make(map[string]bool),
	}
}

func (this *ThroneInheritance) Birth(parentName string, childName string) {
	this.children[parentName] = append(this.children[parentName], childName)
}

func (this *ThroneInheritance) Death(name string) {
	this.dead[name] = true
}

func (this *ThroneInheritance) GetInheritanceOrder() []string {
	var order []string
	var dfs func(personName string)

	dfs = func(personName string) {
		if !this.dead[