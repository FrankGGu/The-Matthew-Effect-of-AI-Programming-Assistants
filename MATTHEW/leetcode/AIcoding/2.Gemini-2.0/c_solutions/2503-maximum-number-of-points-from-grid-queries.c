#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    int val;
} Cell;

int compareCells(const void *a, const void *b) {
    return ((Cell*)a)->val - ((Cell*)b)->val;
}

typedef struct {
    int val;
    int index;
} Query;

int compareQueries(const void *a, const void *b) {
    return ((Query*)a)->val - ((Query*)b)->val;
}

int* maxPoints(int** grid, int gridSize, int* gridColSize, int* queries, int queriesSize, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    Query* sortedQueries = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; i++) {
        sortedQueries[i].val = queries[i];
        sortedQueries[i].index = i;
    }
    qsort(sortedQueries, queriesSize, sizeof(Query), compareQueries);

    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)calloc(cols, sizeof(int));
    }

    int points = 0;
    int queryIndex = 0;
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    Cell* cells = (Cell*)malloc(rows * cols * sizeof(Cell));
    int cellCount = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cells[cellCount].row = i;
            cells[cellCount].col = j;
            cells[cellCount].val = grid[i][j];
            cellCount++;
        }
    }

    qsort(cells, cellCount, sizeof(Cell), compareCells);

    int cellIdx = 0;
    while (queryIndex < queriesSize) {
        int queryVal = sortedQueries[queryIndex].val;
        while (cellIdx < cellCount && cells[cellIdx].val < queryVal) {
            int row = cells[cellIdx].row;
            int col = cells[cellIdx].col;
            if (visited[row][col]) {
                cellIdx++;
                continue;
            }
            visited[row][col] = 1;

            if (row == 0 && col == 0) {
                points++;
            } else {
                int connected = 0;
                for (int k = 0; k < 4; k++) {
                    int newRow = row + dx[k];
                    int newCol = col + dy[k];
                    if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && visited[newRow][newCol]) {
                        connected = 1;
                        break;
                    }
                }
                if(connected || (row == 0 && col == 0)){
                    int count = 0;
                    int q_size = 0;
                    int* q_row = (int*)malloc(rows * cols * sizeof(int));
                    int* q_col = (int*)malloc(rows * cols * sizeof(int));

                    q_row[q_size] = row;
                    q_col[q_size] = col;
                    q_size++;

                    int head = 0;
                    while(head < q_size){
                        int cur_row = q_row[head];
                        int cur_col = q_col[head];
                        head++;
                        count++;

                        for(int k = 0; k < 4; k++){
                            int newRow = cur_row + dx[k];
                            int newCol = cur_col + dy[k];

                            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && visited[newRow][newCol]) {
                                int already_in_queue = 0;
                                for(int j = 0; j < q_size; j++){
                                    if(q_row[j] == newRow && q_col[j] == newCol){
                                        already_in_queue = 1;
                                        break;
                                    }
                                }
                                if(!already_in_queue){
                                    q_row[q_size] = newRow;
                                    q_col[q_size] = newCol;
                                    q_size++;
                                }
                            }
                        }
                    }

                    points = count;
                    free(q_row);
                    free(q_col);
                }
            }
            cellIdx++;
        }
        result[sortedQueries[queryIndex].index] = points;
        queryIndex++;
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    free(sortedQueries);
    free(cells);

    return result;
}