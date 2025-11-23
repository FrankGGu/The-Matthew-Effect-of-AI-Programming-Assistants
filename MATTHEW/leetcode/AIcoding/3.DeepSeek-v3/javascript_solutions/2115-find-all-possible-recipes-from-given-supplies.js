var findAllRecipes = function(recipes, ingredients, supplies) {
    const graph = {};
    const inDegree = {};
    const supplySet = new Set(supplies);
    const recipeSet = new Set(recipes);
    const result = [];

    for (let i = 0; i < recipes.length; i++) {
        const recipe = recipes[i];
        inDegree[recipe] = 0;
        for (const ing of ingredients[i]) {
            if (!supplySet.has(ing)) {
                if (!graph[ing]) {
                    graph[ing] = [];
                }
                graph[ing].push(recipe);
                inDegree[recipe]++;
            }
        }
    }

    const queue = [];
    for (const recipe of recipes) {
        if (inDegree[recipe] === 0) {
            queue.push(recipe);
        }
    }

    while (queue.length > 0) {
        const current = queue.shift();
        result.push(current);

        if (!graph[current]) continue;

        for (const neighbor of graph[current]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return result.filter(item => recipeSet.has(item));
};