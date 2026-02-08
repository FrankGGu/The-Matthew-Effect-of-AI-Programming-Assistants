func findAllPossibleRecipes(ingredients []string, supplies []string, recipes [][]string) []string {
    recipeMap := make(map[string][]string)
    for _, recipe := range recipes {
        recipeMap[recipe[0]] = recipe[1:]
    }

    supplySet := make(map[string]struct{})
    for _, supply := range supplies {
        supplySet[supply] = struct{}{}
    }

    result := []string{}
    canMake := make(map[string]bool)

    var dfs func(string) bool
    dfs = func(recipe string) bool {
        if _, exists := supplySet[recipe]; exists {
            return true
        }
        if made, exists := canMake[recipe]; exists {
            return made
        }
        ingredients, exists := recipeMap[recipe]
        if !exists {
            canMake[recipe] = false
            return false
        }

        for _, ing := range ingredients {
            if !dfs(ing) {
                canMake[recipe] = false
                return false
            }
        }
        canMake[recipe] = true
        result = append(result, recipe)
        return true
    }

    for recipe := range recipeMap {
        dfs(recipe)
    }

    return result
}