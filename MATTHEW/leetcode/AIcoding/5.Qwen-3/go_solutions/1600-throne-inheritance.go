package main

type ThroneInheritance struct {
    kingName string
    children map[string][]string
}

func Constructor(kingName string) ThroneInheritance {
    return ThroneInheritance{
        kingName: kingName,
        children: make(map[string][]string),
    }
}

func (t *ThroneInheritance) Birth(parentName string, childName string) {
    t.children[parentName] = append(t.children[parentName], childName)
}

func (t *ThroneInheritance) Death(name string) {
    // No action needed, since we only track the order of inheritance
    // and do not remove names from the structure
}

func (t *ThroneInheritance) GetInheritanceOrder() []string {
    order := []string{}
    dfs(t.kingName, t.children, &order)
    return order
}

func dfs(name string, children map[string][]string, order *[]string) {
    *order = append(*order, name)
    for _, child := range children[name] {
        dfs(child, children, order)
    }
}