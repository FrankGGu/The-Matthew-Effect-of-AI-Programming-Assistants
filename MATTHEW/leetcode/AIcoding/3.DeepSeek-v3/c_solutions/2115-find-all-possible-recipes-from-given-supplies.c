/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char ** findAllRecipes(char ** recipes, int recipesSize, char *** ingredients, int ingredientsSize, int* ingredientsColSize, char ** supplies, int suppliesSize, int* returnSize) {
    *returnSize = 0;
    char **result = (char **)malloc(recipesSize * sizeof(char *));
    if (!result) return NULL;

    int *canMake = (int *)calloc(recipesSize, sizeof(int));
    if (!canMake) {
        free(result);
        return NULL;
    }

    int *visited = (int *)calloc(recipesSize, sizeof(int));
    if (!visited) {
        free(result);
        free(canMake);
        return NULL;
    }

    for (int i = 0; i < recipesSize; i++) {
        canMake[i] = -1;
    }

    for (int i = 0; i < recipesSize; i++) {
        if (canMake[i] == -1) {
            dfs(recipes, recipesSize, ingredients, ingredientsColSize, supplies, suppliesSize, canMake, visited, i);
        }
    }

    for (int i = 0; i < recipesSize; i++) {
        if (canMake[i] == 1) {
            result[*returnSize] = recipes[i];
            (*returnSize)++;
        }
    }

    free(canMake);
    free(visited);
    return result;
}

int dfs(char **recipes, int recipesSize, char ***ingredients, int* ingredientsColSize, char **supplies, int suppliesSize, int *canMake, int *visited, int idx) {
    if (visited[idx]) {
        return canMake[idx] == 1;
    }

    visited[idx] = 1;

    int possible = 1;
    for (int i = 0; i < ingredientsColSize[idx]; i++) {
        char *ingredient = ingredients[idx][i];
        int found = 0;

        for (int j = 0; j < suppliesSize; j++) {
            if (strcmp(ingredient, supplies[j]) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            for (int j = 0; j < recipesSize; j++) {
                if (strcmp(ingredient, recipes[j]) == 0) {
                    if (dfs(recipes, recipesSize, ingredients, ingredientsColSize, supplies, suppliesSize, canMake, visited, j)) {
                        found = 1;
                        break;
                    }
                }
            }
        }

        if (!found) {
            possible = 0;
            break;
        }
    }

    canMake[idx] = possible;
    return possible;
}