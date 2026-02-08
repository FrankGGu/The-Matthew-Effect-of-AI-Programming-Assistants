#include <stdlib.h>
#include <stdbool.h>

typedef struct Item {
    int dist;
    int price;
    int r;
    int c;
} Item;

int compareItems(const void* a, const void* b) {
    Item* item1 = (Item*)a;
    Item* item2 = (Item*)b;

    if (item1->dist != item2->dist) {
        return item1->dist - item2->dist;
    }
    if (item1->price != item2->price) {
        return item1->price - item2->price;
    }
    if (item1->r != item2->r) {
        return item1->r - item2->r;
    }
    return item1->c - item2->c;
}

typedef struct QueueNode {
    int r, c, d;
} QueueNode;

int** highestRankedKItems(int** grid, int gridSize, int* gridColSize, int* pricing, int pricingSize, int* start, int startSize, int k, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];

    // Distance matrix, initialized to -1 (unvisited)
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = -1;
        }
    }

    // BFS Queue
    QueueNode* queue = (QueueNode*)malloc(rows * cols * sizeof(QueueNode));
    int qHead = 0;
    int qTail = 0;

    // Directions for BFS (up, down, left, right)
    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    // Start BFS
    int startR = start[0];
    int startC = start[1];

    dist[startR][startC] = 0;
    queue[qTail++] = (QueueNode){startR, startC, 0};

    while (qHead < qTail) {
        QueueNode current = queue[qHead++];

        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            // Check bounds
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                // Check if walkable (grid value > 0) and not visited
                if (grid[nr][nc] > 0 && dist[nr][nc] == -1) {
                    dist[nr][nc] = current.d + 1;
                    queue[qTail++] = (QueueNode){nr, nc, current.d + 1};
                }
            }
        }
    }

    // Collect and filter items
    Item* items = (Item*)malloc(rows * cols * sizeof(Item));
    int itemCount = 0;

    int minPrice = pricing[0];
    int maxPrice = pricing[1];

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            // Check if cell is reachable
            if (dist[r][c] != -1) {
                int currentPrice = grid[r][c];
                // Check if the item's price is within the specified range
                if (currentPrice >= minPrice && currentPrice <= maxPrice) {
                    items[itemCount++] = (Item){dist[r][c], currentPrice, r, c};
                }
            }
        }
    }

    // Sort the collected items
    qsort(items, itemCount, sizeof(Item), compareItems);

    // Prepare the result
    int numResults = (itemCount < k) ? itemCount : k;
    *returnSize = numResults;
    *returnColumnSizes = (int*)malloc(numResults * sizeof(int));
    int** result = (int**)malloc(numResults * sizeof(int*));

    for (int i = 0; i < numResults; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = items[i].r;
        result[i][1] = items[i].c;
        (*returnColumnSizes)[i] = 2;
    }

    // Free allocated memory
    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);
    free(queue);
    free(items);

    return result;
}