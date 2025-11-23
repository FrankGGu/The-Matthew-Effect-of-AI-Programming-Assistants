var findAllRecipes = function(recipes, ingredients, supplies) {
    const inDegree = new Map();
    const adj = new Map(); // ingredient -> list of recipes that need this ingredient
    const available = new Set(supplies); // Initially available items

    // Initialize in-degrees for recipes and build adjacency list
    for (let i = 0; i < recipes.length; i++) {
        const recipe = recipes[i];
        const recipeIngredients = ingredients[i];

        inDegree.set(recipe, 0); // Initialize in-degree for each recipe

        for (const ing of recipeIngredients) {
            // If the ingredient is not initially available as a supply,
            // it contributes to the in-degree of the current recipe.
            // We also track which recipes depend on this ingredient.
            if (!available.has(ing)) {
                inDegree.set(recipe, inDegree.get(recipe) + 1);
                if (!adj.has(ing)) {
                    adj.set(ing, []);
                }
                adj.get(ing).push(recipe);
            }
        }
    }

    const q = []; // Queue for BFS (Kahn's algorithm)
    const result = [];

    // Add recipes that have no unmet dependencies (in-degree 0) to the queue.
    // These are recipes whose ingredients are all initially available as supplies.
    for (const recipe of recipes) {
        if (inDegree.get(recipe) === 0) {
            q.push(recipe);
        }
    }

    // Perform BFS
    while (q.length > 0) {
        const currentRecipe = q.shift(); // Dequeue an available recipe
        result.push(currentRecipe); // This recipe can be made

        // Now, this `currentRecipe` itself becomes an available ingredient
        // for other recipes that might depend on it.
        if (adj.has(currentRecipe)) {
            for (const dependentRecipe of adj.get(currentRecipe)) {
                // Decrement the in-degree of the dependent recipe
                inDegree.set(dependentRecipe, inDegree.get(dependentRecipe) - 1);

                // If a dependent recipe's in-degree becomes 0, it means all its ingredients
                // (including `currentRecipe`) are now available, so it can be made.
                if (inDegree.get(dependentRecipe) === 0) {
                    q.push(dependentRecipe);
                }
            }
        }
    }

    return result;
};