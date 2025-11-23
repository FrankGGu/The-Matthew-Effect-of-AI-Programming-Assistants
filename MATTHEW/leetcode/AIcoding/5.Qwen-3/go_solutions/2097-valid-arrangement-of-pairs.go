package main

func validArrangement(pairs [][]int) []int {
    graph := make(map[int][]int)
    inDegree := make(map[int]int)
    outDegree := make(map[int]int)

    for _, pair := range pairs {
        u, v := pair[0], pair[1]
        graph[u] = append(graph[u], v)
        outDegree[u]++
        inDegree[v]++
    }

    startNode := -1
    for node := range graph {
        if outDegree[node] > 0 {
            startNode = node
            break
        }
    }

    if startNode == -1 {
        startNode = pairs[0][0]
    }

    result := []int{}
    var dfs func(u int)
    dfs = func(u int) {
        for len(graph[u]) > 0 {
            v := graph[u][len(graph[u])-1]
            graph[u] = graph[u][:len(graph[u])-1]
            dfs(v)
            result = append(result, v)
        }
    }

    dfs(startNode)
    result = append(result, startNode)
    reverse(result)
    return result
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}