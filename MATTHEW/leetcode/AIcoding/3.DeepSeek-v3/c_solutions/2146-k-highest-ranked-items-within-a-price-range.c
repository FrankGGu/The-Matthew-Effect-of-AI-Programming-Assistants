/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
typedef struct {
    int distance;
    int price;
    int row;
    int col;
} Cell;

int compare(const void* a, const void* b) {
    Cell* cellA = (Cell*)a;
    Cell* cellB = (Cell*)b;

    if (cellA->distance != cellB->distance) {
        return cellA->distance - cellB->distance;
    }
    if (cellA->price != cellB->price) {
        return cellA->price - cellB->price;
    }
    if (cellA->row != cellB->row) {
        return cellA->row - cellB->row;
    }
    return cellA->col - cellB->col;
}

int** highestRankedKItems(int** grid, int gridSize, int* gridColSize, int* pricing, int pricingSize, int* start, int startSize, int k, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];
    int low = pricing[0];
    int high = pricing[1];
    int sr = start[0];
    int sc = start[1];

    int** visited = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        visited[i] = (int*)calloc(n, sizeof(int));
    }

    Cell* cells = (Cell*)malloc(m * n * sizeof(Cell));
    int cellsSize = 0;

    int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    int queue[m * n][3];
    int front = 0, rear = 0;

    queue[rear][0] = sr;
    queue[rear][1] = sc;
    queue[rear][2] = 0;
    rear++;
    visited[sr][sc] = 1;

    if (grid[sr][sc] >= low && grid[sr][sc] <= high) {
        cells[cellsSize].distance = 0;
        cells[cellsSize].price = grid[sr][sc];
        cells[cellsSize].row = sr;
        cells[cellsSize].col = sc;
        cellsSize++;
    }

    while (front < rear) {
        int r = queue[front][0];
        int c = queue[front][1];
        int dist = queue[front][2];
        front++;

        for (int i = 0; i < 4; i++) {
            int nr = r + directions[i][0];
            int nc = c + directions[i][1];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] != 0) {
                visited[nr][nc] = 1;
                queue[rear][0] = nr;
                queue[rear][1] = nc;
                queue[rear][2] = dist + 1;
                rear++;

                if (grid[nr][nc] >= low && grid[nr][nc] <= high) {
                    cells[cellsSize].distance = dist + 1;
                    cells[cellsSize].price = grid[nr][nc];
                    cells[cellsSize].row = nr;
                    cells[cellsSize].col = nc;
                    cellsSize++;
                }
            }
        }
    }

    qsort(cells, cellsSize, sizeof(Cell), compare);

    *returnSize = k < cellsSize ? k : cellsSize;
    int** result = (int**)malloc(*returnSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i < *returnSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = cells[i].row;
        result[i][1] = cells[i].col;
        (*returnColumnSizes)[i] = 2;
    }

    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);
    free(cells);

    return result;
}