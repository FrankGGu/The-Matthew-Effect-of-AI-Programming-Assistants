func largestPathValue(colors string, edges [][]int) int {
    n := len(colors)
    graph := make([][]int, n)
    inDegree := make([]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        inDegree[edge[1]]++
    }

    queue := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    count := make([][]int, n)
    for i := 0; i < n; i++ {
        count[i] = make([]int, 26)
        count[i][colors[i]-'a'] = 1
    }

    visited := 0
    ans := 0

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        visited++
        ans = max(ans, maxVal(count[u]))

        for _, v := range graph[u] {
            for i := 0; i < 26; i++ {
                count[v][i] = max(count[v][i], count[u][i] + (int(colors[v]-'a') == iToInt(i)))
            }

            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    if visited != n {
        return -1
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func maxVal(arr []int) int {
    max := 0
    for _, val := range arr {
        if val > max {
            max = val
        }
    }
    return max
}

func iToInt(i int) int {
    return i
}