var findAllRecipes = function(recipes, ingredients, supplies) {
    const graph = new Map();
    const indegree = new Map();
    const supplySet = new Set(supplies);
    const result = [];

    recipes.forEach((recipe, index) => {
        graph.set(recipe, ingredients[index]);
        indegree.set(recipe, ingredients[index].length);
    });

    const queue = [];
    supplies.forEach(supply => queue.push(supply));

    while (queue.length) {
        const currentSupply = queue.shift();
        for (const [recipe, ingrs] of graph) {
            if (ingrs.every(ingr => supplySet.has(ingr))) {
                indegree.set(recipe, indegree.get(recipe) - 1);
                if (indegree.get(recipe) === 0) {
                    queue.push(recipe);
                    supplySet.add(recipe);
                    result.push(recipe);
                }
            }
        }
    }

    return result;
};