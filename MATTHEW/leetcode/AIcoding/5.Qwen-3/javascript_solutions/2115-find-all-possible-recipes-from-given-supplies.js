function findAllRecipes(recipes, ingredients, supplies) {
    const supplySet = new Set(supplies);
    const graph = {};
    const inDegree = {};
    const result = [];

    for (let i = 0; i < recipes.length; i++) {
        graph[recipes[i]] = [];
        inDegree[recipes[i]] = 0;
        for (const ingredient of ingredients[i]) {
            if (!graph[ingredient]) {
                graph[ingredient] = [];
                inDegree[ingredient] = 0;
            }
            graph[ingredient].push(recipes[i]);
            inDegree[recipes[i]]++;
        }
    }

    const queue = [];
    for (const supply of supplies) {
        queue.push(supply);
    }

    while (queue.length > 0) {
        const current = queue.shift();
        for (const neighbor of graph[current]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                result.push(neighbor);
                queue.push(neighbor);
            }
        }
    }

    return result;
}