package main

func findAllRecipes(ingredients [][]int, supplies []int, recipes []int) []int {
    supplySet := make(map[int]bool)
    for _, s := range supplies {
        supplySet[s] = true
    }

    graph := make(map[int][]int)
    inDegree := make(map[int]int)

    for i, recipe := range recipes {
        for _, ing := range ingredients[i] {
            graph[ing] = append(graph[ing], recipe)
            inDegree[recipe]++
        }
    }

    queue := []int{}
    for _, r := range recipes {
        if inDegree[r] == 0 {
            queue = append(queue, r)
        }
    }

    result := []int{}

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        result = append(result, current)

        for _, next := range graph[current] {
            inDegree[next]--
            if inDegree[next] == 0 {
                queue = append(queue, next)
            }
        }
    }

    return result
}