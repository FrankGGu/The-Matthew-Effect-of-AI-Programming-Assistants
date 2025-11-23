package main

func largestColorValue(graph []int, colors string) int {
    n := len(graph)
    colorCount := make([][26]int, n)
    visited := make([]bool, n)
    inProcess := make([]bool, n)
    maxColor := 0

    var dfs func(int) int
    dfs = func(node int) int {
        if visited[node] {
            return 0
        }
        if inProcess[node] {
            return -1
        }
        inProcess[node] = true

        currentColor := int(colors[node] - 'a')
        maxVal := 1

        for _, neighbor := range graph[node] {
            res := dfs(neighbor)
            if res == -1 {
                return -1
            }
            for i := 0; i < 26; i++ {
                colorCount[node][i] = max(colorCount[node][i], colorCount[neighbor][i])
            }
            maxVal = max(maxVal, colorCount[node][currentColor]+1)
        }

        colorCount[node][currentColor] = max(colorCount[node][currentColor], 1)
        inProcess[node] = false
        visited[node] = true

        return maxVal
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            res := dfs(i)
            if res == -1 {
                return -1
            }
            maxColor = max(maxColor, res)
        }
    }

    return maxColor
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}