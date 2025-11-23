#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point p;
    int count;
} Block;

int compare(const void *a, const void *b) {
    Block *blockA = (Block *)a;
    Block *blockB = (Block *)b;
    if (blockA->p.x != blockB->p.x) return blockA->p.x - blockB->p.x;
    return blockA->p.y - blockB->p.y;
}

int* countBlackBlocks(int n, int m, int** coordinates, int coordinatesSize, int* coordinatesColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (n * m));
    int resultSize = 0;

    Block* blocks = (Block*)malloc(sizeof(Block) * coordinatesSize);
    int blockCount = 0;

    for (int i = 0; i < coordinatesSize; i++) {
        int x = coordinates[i][0];
        int y = coordinates[i][1];
        int found = 0;
        for (int j = 0; j < blockCount; j++) {
            if (blocks[j].p.x == x && blocks[j].p.y == y) {
                blocks[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            blocks[blockCount].p.x = x;
            blocks[blockCount].p.y = y;
            blocks[blockCount].count = 1;
            blockCount++;
        }
    }

    qsort(blocks, blockCount, sizeof(Block), compare);

    for (int i = 0; i < blockCount; i++) {
        int x = blocks[i].p.x;
        int y = blocks[i].p.y;
        int count = blocks[i].count;
        if (count > 0) {
            result[resultSize++] = count;
        }
    }

    free(blocks);
    *returnSize = resultSize;
    return result;
}