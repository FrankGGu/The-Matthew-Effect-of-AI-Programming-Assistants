bool checkValidGrid(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int* visited = (int*)calloc(n * m, sizeof(int));
    int prevX = 0, prevY = 0;

    for (int i = 0; i < n * m; i++) {
        if (grid[i / m][i % m] != i) {
            free(visited);
            return false;
        }
        visited[prevX * m + prevY] = 1;
        int currX = i / m, currY = i % m;
        if (prevX != currX) {
            if (!((abs(prevX - currX) == 2 && abs(prevY - currY) == 1) || 
                  (abs(prevX - currX) == 1 && abs(prevY - currY) == 2))) {
                free(visited);
                return false;
            }
        }
        prevX = currX;
        prevY = currY;
    }
    free(visited);
    return true;
}