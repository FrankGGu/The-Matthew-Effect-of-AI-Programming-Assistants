func findAllRecipes(recipes []string, ingredients [][]string, supplies []string) []string {
    supplySet := make(map[string]bool)
    for _, s := range supplies {
        supplySet[s] = true
    }

    inDegree := make(map[string]int)
    graph := make(map[string][]string)
    for i, recipe := range recipes {
        inDegree[recipe] = 0
        for _, ing := range ingredients[i] {
            if _, exists := supplySet[ing]; !exists {
                graph[ing] = append(graph[ing], recipe)
                inDegree[recipe]++
            }
        }
    }

    queue := []string{}
    for recipe, degree := range inDegree {
        if degree == 0 {
            queue = append(queue, recipe)
        }
    }

    result := []string{}
    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        result = append(result, current)
        for _, neighbor := range graph[current] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return result
}