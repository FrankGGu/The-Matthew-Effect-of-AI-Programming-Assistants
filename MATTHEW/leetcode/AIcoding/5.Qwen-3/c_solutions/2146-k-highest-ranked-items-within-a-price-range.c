#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    int price;
} Item;

int compare(const void *a, const void *b) {
    Item *itemA = (Item *)a;
    Item *itemB = (Item *)b;
    if (itemA->price != itemB->price) {
        return itemA->price - itemB->price;
    }
    if (itemA->row != itemB->row) {
        return itemA->row - itemB->row;
    }
    return itemA->col - itemB->col;
}

int** highestRankedKItems(int** grid, int gridSize, int* gridColSize, int k, int* resultSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    Item *items = NULL;
    int itemCount = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] > 0) {
                items = realloc(items, sizeof(Item) * (itemCount + 1));
                items[itemCount].row = i;
                items[itemCount].col = j;
                items[itemCount].price = grid[i][j];
                itemCount++;
            }
        }
    }

    qsort(items, itemCount, sizeof(Item), compare);

    int **result = malloc(sizeof(int*) * k);
    *resultSize = 0;

    for (int i = 0; i < k && i < itemCount; i++) {
        result[*resultSize] = malloc(sizeof(int) * 2);
        result[*resultSize][0] = items[i].row;
        result[*resultSize][1] = items[i].col;
        (*resultSize)++;
    }

    free(items);
    return result;
}