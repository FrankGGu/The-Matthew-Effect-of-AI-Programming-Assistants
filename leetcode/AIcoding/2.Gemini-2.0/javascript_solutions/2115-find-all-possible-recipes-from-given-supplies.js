var findAllRecipes = function(recipes, ingredients, supplies) {
    const adj = new Map();
    const indegree = new Map();

    for (let i = 0; i < recipes.length; i++) {
        adj.set(recipes[i], []);
        indegree.set(recipes[i], 0);
    }

    for (let i = 0; i < recipes.length; i++) {
        for (const ingredient of ingredients[i]) {
            if (recipes.includes(ingredient)) {
                adj.get(ingredient).push(recipes[i]);
                indegree.set(recipes[i], (indegree.get(recipes[i]) || 0) + 1);
            }
        }
    }

    const q = [];
    for (const recipe of recipes) {
        if (indegree.get(recipe) === 0 && !supplies.includes(recipe)) {
             let possible = true;
             for(let i = 0; i < ingredients[recipes.indexOf(recipe)].length; i++){
                 if(!supplies.includes(ingredients[recipes.indexOf(recipe)][i])){
                     possible = false;
                     break;
                 }
             }
            if(possible){
                q.push(recipe);
            }
        } else if (indegree.get(recipe) === 0 && supplies.includes(recipe)) {
            q.push(recipe);
        } else if (!indegree.has(recipe) && !supplies.includes(recipe)) {
            let possible = true;
             for(let i = 0; i < ingredients[recipes.indexOf(recipe)].length; i++){
                 if(!supplies.includes(ingredients[recipes.indexOf(recipe)][i])){
                     possible = false;
                     break;
                 }
             }
            if(possible){
                q.push(recipe);
            }
        } else if (!indegree.has(recipe) && supplies.includes(recipe)){
            q.push(recipe);
        }
    }

    for(let i = 0; i < recipes.length; i++){
        if(!indegree.has(recipes[i]) && !supplies.includes(recipes[i])){
            let possible = true;
            for(let j = 0; j < ingredients[i].length; j++){
                if(!supplies.includes(ingredients[i][j])){
                    possible = false;
                    break;
                }
            }
            if(possible){
                 if(!q.includes(recipes[i])){
                     q.push(recipes[i]);
                 }
            }
        }
    }

    let supplySet = new Set(supplies);
    for(let recipe of recipes){
        supplySet.add(recipe);
    }

    let startNodes = recipes.filter(recipe => {
         for(let ingredient of ingredients[recipes.indexOf(recipe)]){
             if(!supplySet.has(ingredient)){
                 return false;
             }
         }
         return true;
    });

    const result = [];
    const visited = new Set(supplies);

    function dfs(recipe) {
        if (visited.has(recipe)) {
            return;
        }

        let canMake = true;
        for (const ingredient of ingredients[recipes.indexOf(recipe)]) {
            if (!visited.has(ingredient)) {
                canMake = false;
                break;
            }
        }

        if (canMake) {
            visited.add(recipe);
            result.push(recipe);
        }
    }

    for (const recipe of recipes) {
        dfs(recipe);
    }

    return result;
};