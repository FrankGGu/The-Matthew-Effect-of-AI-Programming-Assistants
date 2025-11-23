#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    int distance;
    int price;
} Item;

int compare(const void *a, const void *b) {
    Item *item1 = (Item *)a;
    Item *item2 = (Item *)b;

    if (item1->distance != item2->distance) {
        return item1->distance - item2->distance;
    }
    if (item1->price != item2->price) {
        return item1->price - item2->price;
    }
    if (item1->row != item2->row) {
        return item1->row - item2->row;
    }
    return item1->col - item2->col;
}

int** highestRankedKItems(int** grid, int gridSize, int* gridColSize, int* pricing, int* start, int k, int* returnSize, int** returnColumnSizes) {
    int low = pricing[0];
    int high = pricing[1];
    int startRow = start[0];
    int startCol = start[1];

    int rows = gridSize;
    int cols = gridColSize[0];

    bool visited[rows][cols];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    Item items[rows * cols];
    int itemCount = 0;

    int queue[rows * cols][2];
    int queueFront = 0;
    int queueRear = 0;

    queue[queueRear][0] = startRow;
    queue[queueRear][1] = startCol;
    queueRear++;
    visited[startRow][startCol] = true;

    int distance = 0;

    while (queueFront < queueRear) {
        int queueSize = queueRear - queueFront;

        for (int i = 0; i < queueSize; i++) {
            int row = queue[queueFront][0];
            int col = queue[queueFront][1];
            queueFront++;

            if (grid[row][col] >= low && grid[row][col] <= high) {
                items[itemCount].row = row;
                items[itemCount].col = col;
                items[itemCount].distance = distance;
                items[itemCount].price = grid[row][col];
                itemCount++;
            }

            int dr[] = {-1, 1, 0, 0};
            int dc[] = {0, 0, -1, 1};

            for (int j = 0; j < 4; j++) {
                int newRow = row + dr[j];
                int newCol = col + dc[j];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] != 0 && !visited[newRow][newCol]) {
                    queue[queueRear][0] = newRow;
                    queue[queueRear][1] = newCol;
                    queueRear++;
                    visited[newRow][newCol] = true;
                }
            }
        }
        distance++;
    }

    qsort(items, itemCount, sizeof(Item), compare);

    *returnSize = (itemCount < k) ? itemCount : k;
    *returnColumnSizes = (int*)malloc(sizeof(int) * (*returnSize));
    int** result = (int**)malloc(sizeof(int*) * (*returnSize));

    for (int i = 0; i < *returnSize; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = items[i].row;
        result[i][1] = items[i].col;
        (*returnColumnSizes)[i] = 2;
    }

    return result;
}