func findTheEdges(n int, edges [][]int, startNode int, targetNode int) []int {
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v, idx := edge[0], edge[1], edge[2]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	dist := make([]int, n)
	for i := range dist {
		dist[i] = -1
	}
	dist[startNode] = 0

	queue := []int{startNode}
	for len(queue) > 0 {
		u := queue[0]
		queue = queue[1:]

		for _, v := range graph[u] {
			if dist[v] == -1 {
				dist[v] = dist[u] + 1
				queue = append(queue, v)
			}
		}
	}

	if dist[targetNode] == -1 {
		return []int{}
	}

	shortestPathEdges := []int{}
	for _, edge := range edges {
		u, v, idx := edge[0], edge[1], edge[2]
		if (dist[u] != -1 && dist[v] != -1) && (dist[u]+1 == dist[v] || dist[v]+1 == dist[u]) {

			distU := dist[u]
			distV := dist[v]

			if distU > distV{
				distU,distV = distV,distU
			}

			if distU+1 == distV{

				path := []int{}

				curr := targetNode
				path = append(path,curr)

				for curr != startNode{

					foundNext := false
					for i := 0; i < n; i++ {

						if i == curr{
							continue
						}

						found := false
						for _, neighbor := range graph[curr]{
							if neighbor == i{
								found = true
								break
							}
						}

						if !found {
							continue
						}

						if dist[i] == dist[curr] - 1{

							curr = i
							path = append(path, curr)
							foundNext = true
							break
						}
					}
					if !foundNext{
						break
					}
				}

				reverse(path)

				isEdgeInPath := false
				for i := 0; i < len(path) -1; i++{
					uPath, vPath := path[i], path[i+1]

					if (uPath == u && vPath == v) || (uPath == v && vPath == u){
						isEdgeInPath = true
						break
					}
				}

				if isEdgeInPath{
					shortestPathEdges = append(shortestPathEdges, idx)
				}
			}
		}
	}

	return shortestPathEdges
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}