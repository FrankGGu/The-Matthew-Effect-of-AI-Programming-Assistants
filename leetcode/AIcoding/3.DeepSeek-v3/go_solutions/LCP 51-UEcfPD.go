func perfectMenu(ingredients [][]int, cookbooks [][]int, attribute [][]int, limit int) int {
    maxDelicious := -1
    n := len(cookbooks)

    var dfs func(int, int, int, []int)
    dfs = func(index, currentDelicious, currentFull int, remainingIngredients []int) {
        if currentFull >= limit {
            if currentDelicious > maxDelicious {
                maxDelicious = currentDelicious
            }
        }
        if index == n {
            return
        }
        // Option 1: skip current cookbook
        dfs(index+1, currentDelicious, currentFull, remainingIngredients)
        // Option 2: choose current cookbook
        newIngredients := make([]int, len(remainingIngredients))
        copy(newIngredients, remainingIngredients)
        valid := true
        for i := 0; i < len(newIngredients); i++ {
            if newIngredients[i] < cookbooks[index][i] {
                valid = false
                break
            }
            newIngredients[i] -= cookbooks[index][i]
        }
        if valid {
            dfs(index+1, currentDelicious + attribute[index][0], currentFull + attribute[index][1], newIngredients)
        }
    }

    initialIngredients := make([]int, len(ingredients))
    for i := range ingredients {
        initialIngredients[i] = ingredients[i][0]
    }
    dfs(0, 0, 0, initialIngredients)
    return maxDelicious
}