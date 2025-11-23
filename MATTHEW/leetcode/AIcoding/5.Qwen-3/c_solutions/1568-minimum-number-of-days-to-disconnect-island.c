#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int** grid;
    int rows;
    int cols;
    int** visited;
} Context;

int dfs(Context* ctx, int i, int j) {
    if (i < 0 || i >= ctx->rows || j < 0 || j >= ctx->cols || ctx->grid[i][j] == 0 || ctx->visited[i][j]) {
        return 0;
    }
    ctx->visited[i][j] = 1;
    int area = 1;
    area += dfs(ctx, i + 1, j);
    area += dfs(ctx, i - 1, j);
    area += dfs(ctx, i, j + 1);
    area += dfs(ctx, i, j - 1);
    return area;
}

int countIslands(Context* ctx) {
    int count = 0;
    for (int i = 0; i < ctx->rows; i++) {
        for (int j = 0; j < ctx->cols; j++) {
            if (ctx->grid[i][j] == 1 && !ctx->visited[i][j]) {
                dfs(ctx, i, j);
                count++;
            }
        }
    }
    return count;
}

int minDays(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    Context ctx = { grid, rows, cols, (int**)malloc(rows * sizeof(int*)) };
    for (int i = 0; i < rows; i++) {
        ctx.visited[i] = (int*)malloc(cols * sizeof(int));
        memset(ctx.visited[i], 0, cols * sizeof(int));
    }

    int islands = countIslands(&ctx);
    if (islands != 1) {
        for (int i = 0; i < rows; i++) {
            free(ctx.visited[i]);
        }
        free(ctx.visited);
        return 0;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                grid[i][j] = 0;
                Context tempCtx = { grid, rows, cols, (int**)malloc(rows * sizeof(int*)) };
                for (int k = 0; k < rows; k++) {
                    tempCtx.visited[k] = (int*)malloc(cols * sizeof(int));
                    memset(tempCtx.visited[k], 0, cols * sizeof(int));
                }
                int newIslands = countIslands(&tempCtx);
                for (int k = 0; k < rows; k++) {
                    free(tempCtx.visited[k]);
                }
                free(tempCtx.visited);
                grid[i][j] = 1;
                if (newIslands != 1) {
                    for (int k = 0; k < rows; k++) {
                        free(ctx.visited[k]);
                    }
                    free(ctx.visited);
                    return 1;
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(ctx.visited[i]);
    }
    free(ctx.visited);
    return 2;
}