#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int* ingredients;
    int ingredientsSize;
} Recipe;

typedef struct {
    char* name;
    int index;
} Supply;

int compare(const void* a, const void* b) {
    return strcmp(((Supply*)a)->name, ((Supply*)b)->name);
}

int contains(char** supplies, int suppliesSize, char* s) {
    for (int i = 0; i < suppliesSize; i++) {
        if (strcmp(supplies[i], s) == 0) return 1;
    }
    return 0;
}

int* findPossibleRecipes(char** recipes, int recipesSize, char*** ingredients, int* ingredientSizes, char** supplies, int suppliesSize, int* returnSize) {
    int* result = (int*)malloc(recipesSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < recipesSize; i++) {
        int canMake = 1;
        for (int j = 0; j < ingredientSizes[i]; j++) {
            if (!contains(supplies, suppliesSize, ingredients[i][j])) {
                canMake = 0;
                break;
            }
        }
        if (canMake) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}