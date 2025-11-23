#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y, height;
} Cell;

int trapRainWater(int** heightMap, int heightSize, int* heightColSize) {
    if (heightSize <= 2 || heightColSize[0] <= 2) {
        return 0;
    }

    int m = heightSize;
    int n = heightColSize[0];
    int visited[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = 0;
        }
    }

    Cell* heap = (Cell*)malloc(m * n * sizeof(Cell));
    int heapSize = 0;

    void swap(Cell* a, Cell* b) {
        Cell temp = *a;
        *a = *b;
        *b = temp;
    }

    void minHeapify(int i) {
        int smallest = i;
        int left = 2 * i + 1;
        int right = 2 * i + 2;

        if (left < heapSize && heap[left].height < heap[smallest].height) {
            smallest = left;
        }

        if (right < heapSize && heap[right].height < heap[smallest].height) {
            smallest = right;
        }

        if (smallest != i) {
            swap(&heap[i], &heap[smallest]);
            minHeapify(smallest);
        }
    }

    void insert(int x, int y, int height) {
        heap[heapSize].x = x;
        heap[heapSize].y = y;
        heap[heapSize].height = height;

        int i = heapSize;
        while (i > 0 && heap[i].height < heap[(i - 1) / 2].height) {
            swap(&heap[i], &heap[(i - 1) / 2]);
            i = (i - 1) / 2;
        }
        heapSize++;
    }

    int extractMin() {
        if (heapSize <= 0) {
            return -1;
        }
        if (heapSize == 1) {
            heapSize--;
            return 0;
        }

        heap[0] = heap[heapSize - 1];
        heapSize--;
        minHeapify(0);
        return 0;
    }

    for (int i = 0; i < m; i++) {
        insert(i, 0, heightMap[i][0]);
        visited[i][0] = 1;
        insert(i, n - 1, heightMap[i][n - 1]);
        visited[i][n - 1] = 1;
    }
    for (int j = 1; j < n - 1; j++) {
        insert(0, j, heightMap[0][j]);
        visited[0][j] = 1;
        insert(m - 1, j, heightMap[m - 1][j]);
        visited[m - 1][j] = 1;
    }

    int water = 0;
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    while (heapSize > 0) {
        Cell current = heap[0];
        extractMin();

        for (int i = 0; i < 4; i++) {
            int newX = current.x + dx[i];
            int newY = current.y + dy[i];

            if (newX >= 0 && newX < m && newY >= 0 && newY < n && !visited[newX][newY]) {
                visited[newX][newY] = 1;
                if (heightMap[newX][newY] < current.height) {
                    water += current.height - heightMap[newX][newY];
                    insert(newX, newY, current.height);
                } else {
                    insert(newX, newY, heightMap[newX][newY]);
                }
            }
        }
    }

    free(heap);
    return water;
}