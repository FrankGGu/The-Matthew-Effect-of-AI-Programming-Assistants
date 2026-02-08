#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int height;
    int r;
    int c;
} Cell;

Cell heap[40000];
int heapSize;

void swap(Cell* a, Cell* b) {
    Cell temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(int index) {
    while (index > 0 && heap[index].height < heap[(index - 1) / 2].height) {
        swap(&heap[index], &heap[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

void heapifyDown(int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heapSize && heap[left].height < heap[smallest].height) {
        smallest = left;
    }
    if (right < heapSize && heap[right].height < heap[smallest].height) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap[index], &heap[smallest]);
        heapifyDown(smallest);
    }
}

void push(Cell cell) {
    heap[heapSize++] = cell;
    heapifyUp(heapSize - 1);
}

Cell pop() {
    Cell minCell = heap[0];
    heap[0] = heap[--heapSize];
    heapifyDown(0);
    return minCell;
}

void initHeap() {
    heapSize = 0;
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize == 0 || *heightMapColSize == 0) {
        return 0;
    }

    int m = heightMapSize;
    int n = *heightMapColSize;

    // Allocate and initialize visited array
    bool** visited = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)calloc(n, sizeof(bool)); // calloc initializes to false
    }

    initHeap();

    // Add all border cells to the priority queue
    // Top and bottom rows
    for (int j = 0; j < n; j++) {
        push((Cell){heightMap[0][j], 0, j});
        visited[0][j] = true;
        push((Cell){heightMap[m - 1][j], m - 1, j});
        visited[m - 1][j] = true;
    }
    // Left and right columns (excluding corners already added)
    for (int i = 1; i < m - 1; i++) {
        push((Cell){heightMap[i][0], i, 0});
        visited[i][0] = true;
        push((Cell){heightMap[i][n - 1], i, n - 1});
        visited[i][n - 1] = true;
    }

    int trappedWater = 0;

    // Directions for neighbors (up, down, left, right)
    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (heapSize > 0) {
        Cell current = pop();
        int r = current.r;
        int c = current.c;
        int h = current.height; // This is the effective wall height encountered so far

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds and if the neighbor has not been visited
            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                visited[nr][nc] = true;

                // Calculate water trapped at this neighbor
                // Water is trapped if the current effective wall height (h) is greater than the neighbor's actual height
                trappedWater += (h > heightMap[nr][nc] ? h - heightMap[nr][nc] : 0);

                // Add neighbor to PQ. Its effective wall height is the maximum of the current effective wall height
                // and its own actual height. This ensures water cannot flow out through a lower path.
                push((Cell){h > heightMap[nr][nc] ? h : heightMap[nr][nc], nr, nc});
            }
        }
    }

    // Free allocated memory for the visited array
    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);

    return trappedWater;
}