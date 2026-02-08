type Node struct {
	Val   int
	Neighbors []*Node
}

func buildGraph(properties [][]int) []*Node {
	n := len(properties)
	nodes := make([]*Node, n)
	for i := 0; i < n; i++ {
		nodes[i] = &Node{Val: i}
	}

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if areConnected(properties[i], properties[j]) {
				nodes[i].Neighbors = append(nodes[i].Neighbors, nodes[j])
				nodes[j].Neighbors = append(nodes[j].Neighbors, nodes[i])
			}
		}
	}

	return nodes
}

func areConnected(p1, p2 []int) bool {
	count := 0
	for i := 0; i < len(p1); i++ {
		if p1[i] == 1 && p2[i] == 1 {
			count++
		}
	}
	return count >= 2
}