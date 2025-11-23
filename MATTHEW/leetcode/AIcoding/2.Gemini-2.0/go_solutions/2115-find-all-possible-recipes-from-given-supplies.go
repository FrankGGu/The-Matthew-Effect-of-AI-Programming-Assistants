func findAllRecipes(recipes []string, ingredients [][]string, supplies []string) []string {
    graph := make(map[string][]string)
    indegree := make(map[string]int)
    supplyMap := make(map[string]bool)

    for _, s := range supplies {
        supplyMap[s] = true
    }

    for i := 0; i < len(recipes); i++ {
        recipe := recipes[i]
        indegree[recipe] = 0
    }

    for i := 0; i < len(recipes); i++ {
        recipe := recipes[i]
        for _, ingredient := range ingredients[i] {
            if _, ok := supplyMap[ingredient]; !ok {
                if _, ok2 := indegree[ingredient]; !ok2 {
                    indegree[ingredient] = 0
                }
                graph[ingredient] = append(graph[ingredient], recipe)
                indegree[recipe]++
            }
        }
    }

    queue := []string{}
    for k, v := range indegree {
        if v == 0 {

            canMake := true
            for i:=0; i < len(recipes); i++ {
                if recipes[i] == k {
                    for _, ingredient := range ingredients[i] {
                        if _, ok := supplyMap[ingredient]; !ok {
                            canMake = false
                            break
                        }
                    }
                }
            }

            if canMake {
                queue = append(queue, k)
            }

        }
    }

    result := []string{}

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        result = append(result, node)

        for _, neighbor := range graph[node] {
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    possibleRecipes := []string{}
    for _, recipe := range recipes {
        found := false
        for _, r := range result {
            if recipe == r {
                found = true
                break
            }
        }
        if found {
            possibleRecipes = append(possibleRecipes, recipe)
        }
    }

    return possibleRecipes
}